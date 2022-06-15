package com.example.demo.services;

import com.example.demo.dto.ReviewDTO;
import com.example.demo.model.Review;
import com.example.demo.repository.ReviewRepository;
import com.example.demo.vo.ReviewsQueryVO;
import com.example.demo.vo.ReviewsUpdateVO;
import com.example.demo.vo.ReviewsVO;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

import java.util.NoSuchElementException;

@Service
public class ReviewService {

    @Autowired
    private ReviewRepository reviewRepository;

    public Long save(ReviewsVO vO) {
        Review bean = new Review();
        BeanUtils.copyProperties(vO, bean);
        bean = reviewRepository.save(bean);
        return bean.getRevId();
    }

    public void delete(Long id) {
        reviewRepository.deleteById(id);
    }

    public void update(Long id, ReviewsUpdateVO vO) {
        Review bean = requireOne(id);
        BeanUtils.copyProperties(vO, bean);
        reviewRepository.save(bean);
    }

    public ReviewDTO getById(Long id) {
        Review original = requireOne(id);
        return toDTO(original);
    }

    public Page<ReviewDTO> query(ReviewsQueryVO vO) {
        throw new UnsupportedOperationException();
    }

    private ReviewDTO toDTO(Review original) {
        ReviewDTO bean = new ReviewDTO();
        BeanUtils.copyProperties(original, bean);
        return bean;
    }

    private Review requireOne(Long id) {
        return reviewRepository.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Resource not found: " + id));
    }
}
