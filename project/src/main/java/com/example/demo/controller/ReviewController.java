package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.example.demo.service.ReviewService;
import com.example.demo.vo.ResultData;
import com.example.demo.vo.ProductReview;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.security.Principal;
import java.util.List;

@Controller
@RequestMapping("/reviews")
public class ReviewController {

    @Autowired
    private ReviewService reviewService;

    private static final int REVIEWS_PER_PAGE = 10; // Number of reviews displayed per page
    private static final Logger logger = LoggerFactory.getLogger(ReviewController.class);

    // Fetch reviews for a specific product with pagination
    @GetMapping("/{productId}")
    public String getReviews(@PathVariable int productId, 
                             @RequestParam(defaultValue = "1") int page, 
                             Model model) {
        // Get total review count
        int totalReviews = reviewService.getTotalReviewCountByProductId(productId);
        int totalPages = (int) Math.ceil((double) totalReviews / REVIEWS_PER_PAGE);

        // Get paginated reviews
        ResultData<List<ProductReview>> result = reviewService.getReviewsByProductIdWithPagination(productId, page, REVIEWS_PER_PAGE);

        if (result.isFail()) {
            model.addAttribute("errorMessage", result.getMsg());
        } else {
            model.addAttribute("reviews", result.getData1());
        }

        // Provide pagination info
        model.addAttribute("productId", productId);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);

        return "product/detail"; // Return the view name for the product details page
    }

    @PostMapping("/add")
    public String addReview(@RequestParam Integer productId,  
                             @RequestParam String content,
                             @RequestParam(required = false) Integer rating,
                             RedirectAttributes redirectAttributes,
                             Principal principal) {
        logger.info("Received review submission for productId: {}", productId);

        // Validate rating
        if (rating == null || rating < 1 || rating > 5) {
            redirectAttributes.addFlashAttribute("error", "유효한 별점을 선택하세요.");
            return "redirect:/product/article/detail?id=" + productId; // Redirect to product detail page
        }

        // Check if the user is logged in
        if (principal == null) {
            redirectAttributes.addFlashAttribute("error", "로그인 후에 리뷰를 작성할 수 있습니다.");
            return "redirect:/product/article/detail?id=" + productId; // Redirect to product detail page
        }

        String userName = principal.getName(); // 로그인한 사용자의 이름 가져오기
        String writerNickname = userName; // 이 예에서는 닉네임을 사용자 이름으로 설정

        // Add the review
        ResultData<String> result = reviewService.addReview(productId, userName, content, rating, writerNickname);

        // Handle result of review addition
        if (result.isFail()) {
            redirectAttributes.addFlashAttribute("error", result.getMsg());
        } else {
            redirectAttributes.addFlashAttribute("success", "리뷰가 추가되었습니다.");
        }

        // Redirect to the product detail page with productId
        return "redirect:/product/article/detail?id=" + productId; // Redirect to product detail page
    }
}