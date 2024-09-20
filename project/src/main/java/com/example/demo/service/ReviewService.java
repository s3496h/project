package com.example.demo.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.example.demo.repository.ReviewRepository;
import com.example.demo.vo.ProductReview;
import com.example.demo.vo.ResultData;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Service
public class ReviewService {

    @Autowired
    private ReviewRepository reviewRepository;

    private static final Logger logger = LoggerFactory.getLogger(ReviewService.class);

    // Get reviews for a product with pagination
    public ResultData<List<ProductReview>> getReviewsByProductIdWithPagination(int productId, int page, int reviewsPerPage) {
        int offset = (page - 1) * reviewsPerPage; // Calculate the offset based on the page number
        List<ProductReview> reviews = reviewRepository.getProductReviewsWithPagination(productId, offset, reviewsPerPage);
        
        if (reviews.isEmpty()) {
            return ResultData.from("F-1", "리뷰가 없습니다.");
        }

        return ResultData.from("S-1", "리뷰를 불러왔습니다.", "reviews", reviews);
    }

    // Get total number of reviews for a product
    public int getTotalReviewCountByProductId(int productId) {
        return reviewRepository.countReviewsByProductId(productId);
    }

    // Add a new review
    public ResultData<String> addReview(int productId, String userName, String content, int rating, String writerNickname) {
        // Validate inputs
        if (userName == null || userName.trim().isEmpty()) {
            return ResultData.from("F-2", "사용자 이름을 입력하세요.");
        }
        if (writerNickname == null || writerNickname.trim().isEmpty()) {
            return ResultData.from("F-5", "작성자의 닉네임을 입력하세요.");
        }
        if (content == null || content.trim().isEmpty()) {
            return ResultData.from("F-3", "리뷰 내용을 입력하세요.");
        }
        if (rating < 1 || rating > 5) {
            return ResultData.from("F-4", "유효한 별점을 선택하세요.");
        }

        try {
            reviewRepository.addReview(productId, userName, content, rating, writerNickname);
            return ResultData.from("S-2", "리뷰가 추가되었습니다.");
        } catch (Exception e) {
            logger.error("Error adding review: {}", e.getMessage());
            return ResultData.from("F-1", "리뷰 추가에 실패했습니다: " + e.getMessage());
        }
    }
}