package com.example.demo.generator;

import com.example.demo.model.KmeanOrder;
import com.example.demo.services.OrderService;
import java.time.LocalDate;
import java.util.*;
import java.util.stream.Collectors;
public class KMeansEngine {
    public static final Random random=new Random();
    OrderService orderService;

    public KMeansEngine(OrderService orderService) {
        this.orderService = orderService;
    }

    public  Map<Centroid, List<KmeanOrder>> fit(int k, String date){
        LocalDate dateConverted=LocalDate.parse(date);
        int maxIterations=1000;
        EuclidianDistance distance=new EuclidianDistance();
        List<KmeanOrder> orders=orderService.getAll(dateConverted);
        List<Centroid> centroids=upgradeCentroids(orders,k);//generate centroids for KMeans++
        Map<Centroid, List<KmeanOrder>> clusters = new HashMap<>();
        Map<Centroid, List<KmeanOrder>> lastState = new HashMap<>();

        for (int index = 0; index < maxIterations; index++) {
            boolean isLastIteration = index == maxIterations - 1;
            for (KmeanOrder order : orders) {
                Centroid centroid = nearestCentroid(order, centroids, distance);
                assignOrderToCluster(order, centroid,clusters);
            }
            boolean stopRun = isLastIteration || clusters.equals(lastState);
            lastState = clusters;
            if (stopRun) {
                break;
            }
            centroids = relocateCentroids(clusters);
            clusters = new HashMap<>();
        }

        return lastState;
    }
    private static List<Centroid> upgradeCentroids(List<KmeanOrder> orders, int k){
        List<Centroid> centroids = new ArrayList<>();
        EuclidianDistance distance=new EuclidianDistance();
        int ordersNumber=orders.size();
        final boolean[] choosen = new boolean[ordersNumber];
        final double[] squaredDistances=new double[ordersNumber];
        int firstClusterIndex=random.nextInt(ordersNumber);
        choosen[firstClusterIndex]=true;
        Centroid firstCentroid=new Centroid(orders.get(firstClusterIndex).getCoordonates());
        centroids.add(firstCentroid);
        for(int index=0;index<ordersNumber;index++){
            if(index!=firstClusterIndex){
                double d=distance.calculateDistance(firstCentroid.getCentroidCoordonates(),orders.get(index).getCoordonates());
                squaredDistances[index]=d*d;
            }
        }
        while(centroids.size()<k){
            double distancesSquredSum=0;
            for(int index=0;index<ordersNumber;index++){
                if(!choosen[index]){
                    distancesSquredSum+=squaredDistances[index];
                }
            }
            final double referenceValue = random.nextDouble() * distancesSquredSum;
            int nextClusterIndex = -1;
            double sum = 0.0;
            for (int index = 0; index < ordersNumber; index++) {
                if (!choosen[index]) {
                    sum += squaredDistances[index];
                    if (sum >= referenceValue) {
                        nextClusterIndex = index;
                        break;
                    }
                }
            }
            if (nextClusterIndex == -1) {
                for (int index = ordersNumber - 1; index >= 0; index--) {
                    if (!choosen[index]) {
                        nextClusterIndex = index;
                        break;
                    }
                }
            }

            if (nextClusterIndex >= 0) {
                final KmeanOrder nextCentroid = orders.get(nextClusterIndex);
                centroids.add(new Centroid(nextCentroid.getCoordonates()));
                choosen[nextClusterIndex] = true;
                if (centroids.size() < k) {
                    for (int j = 0; j < ordersNumber; j++) {
                        if (!choosen[j]) {
                            double d = distance.calculateDistance(nextCentroid.getCoordonates(), orders.get(j).getCoordonates());
                            double d2 = d * d;
                            if (d2 < squaredDistances[j]) {
                                squaredDistances[j] = d2;
                            }
                        }
                    }
                }

            } else {
                break;
            }
        }
        return centroids;

    }
    private static Centroid nearestCentroid(KmeanOrder order, List<Centroid> centroids, EuclidianDistance distance) {
        double minimumDistance = 1000000000;
        Centroid nearest = null;
        for (Centroid centroid : centroids) {
            double current = distance.calculateDistance(order.getCoordonates(), centroid.getCentroidCoordonates());
            if (current< minimumDistance) {
                minimumDistance = current;
                nearest = centroid;
            }
        }

        return nearest;
    }
    private static void assignOrderToCluster(KmeanOrder order,
                                            Centroid centroid,
                                            Map<Centroid, List<KmeanOrder>> clusters) {
        clusters.compute(centroid, (key, list) -> {
            if (list == null) {
                list = new ArrayList<>();
            }

            list.add(order);
            return list;
        });
    }
    private static Centroid calculateAverage(Centroid centroid, List<KmeanOrder> orders) {
        if (orders == null || orders.isEmpty()) {
            return centroid;
        }
        Map<String, Double> average = centroid.getCentroidCoordonates();
        orders.stream().flatMap(order->order.getCoordonates().keySet().stream())
                .forEach(k -> average.put(k, 0.0));

        for (KmeanOrder order : orders) {
            order.getCoordonates().forEach(
                    (k, v) -> average.compute(k, (k1, currentValue) -> v + currentValue)
            );
        }

        average.forEach((k, v) -> average.put(k, v / orders.size()));
        return new Centroid(average);
    }
    private static List<Centroid> relocateCentroids(Map<Centroid, List<KmeanOrder>> clusters) {
        return clusters.entrySet().stream().map(cluster -> calculateAverage(cluster.getKey(), cluster.getValue())).collect(Collectors.toList());
    }
}
