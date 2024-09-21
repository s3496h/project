package com.example.demo.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.example.demo.repository.ReviewRepository;
import com.example.demo.util.Ut;
import com.example.demo.vo.ProductReview;
import com.example.demo.vo.ResultData;

@Service
public class ReviewService {

    @Autowired
    private ReviewRepository reviewRepository;

    public ResultData<List<ProductReview>> getReviewsByProductIdWithPagination(int productId, int page, int reviewsPerPage) {
        int offset = (page - 1) * reviewsPerPage;
        List<ProductReview> reviews = reviewRepository.getForPrintProductReviews(productId, offset, reviewsPerPage);
        return ResultData.from("S-1", "리뷰 목록을 가져왔습니다.", "reviews", reviews);
    }

    public int getTotalReviewCountByProductId(int productId) {
        return reviewRepository.getTotalReviewCountByProductId(productId);
    }

    public ResultData<ProductReview> addReview(int memberId, int productId, String content, String nickname, int rating) {
        reviewRepository.writeProductReview(memberId, productId, content, rating);
        int id = reviewRepository.getLastInsertId();

        // extra__writer 필드 추가
        ProductReview review = new ProductReview(id, productId, content, nickname, rating, null, memberId);
        review.setExtra__writer(nickname); // extra__writer 필드 설정

        return ResultData.from("S-1", "리뷰가 등록되었습니다.", "review", review);
    }

    public List<ProductReview> getReviewsByProductId(int productId, int offset, int reviewsPerPage) {
        return reviewRepository.getForPrintProductReviews(productId, offset, reviewsPerPage);
    }

    public ProductReview getProductReview(int id) {
        return reviewRepository.getProductReview(id);
    }

    public void modifyProductReview(int id, String content, int rating) {
        reviewRepository.modifyProductReview(id, content, rating);
    }

    public ResultData userCanModify(int loginedMemberId, ProductReview review) {
        if (review.getMemberId() != loginedMemberId) {
            return ResultData.from("F-2", Ut.f("%d번 리뷰에 대한 수정 권한이 없습니다", review.getId()));
        }
        return ResultData.from("S-1", Ut.f("%d번 리뷰를 수정했습니다", review.getId()));
    }

    // 평균 별점 계산 메서드 추가
    public double calculateAverageRating(int productId) {
        List<ProductReview> reviews = reviewRepository.getForPrintProductReviews(productId, 0, Integer.MAX_VALUE); // 모든 리뷰 가져오기
        if (reviews.isEmpty()) return 0;
        double totalRating = 0;
        for (ProductReview review : reviews) {
            totalRating += review.getRating();
        }
        return totalRating / reviews.size(); // 평균 별점 반환
    }
}