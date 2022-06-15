package com.example.demo.controller;

import com.example.demo.dto.ReviewDTO;
import com.example.demo.services.ReviewService;
import com.example.demo.vo.ReviewsQueryVO;
import com.example.demo.vo.ReviewsUpdateVO;
import com.example.demo.vo.ReviewsVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;

@Validated
@RestController
@RequestMapping("/reviews")
public class ReviewController {

    @Autowired
    private ReviewService reviewService;

    @PostMapping
    public String save(@Valid @RequestBody ReviewsVO vO) {
        return reviewService.save(vO).toString();
    }

    @DeleteMapping("/{id}")
    public void delete(@Valid @NotNull @PathVariable("id") Long id) {
        reviewService.delete(id);
    }

    @PutMapping("/{id}")
    public void update(@Valid @NotNull @PathVariable("id") Long id,
                       @Valid @RequestBody ReviewsUpdateVO vO) {
        reviewService.update(id, vO);
    }

    @GetMapping("/{id}")
    public ReviewDTO getById(@Valid @NotNull @PathVariable("id") Long id) {
        return reviewService.getById(id);
    }

    @GetMapping
    public Page<ReviewDTO> query(@Valid ReviewsQueryVO vO) {
        return reviewService.query(vO);
    }
}
