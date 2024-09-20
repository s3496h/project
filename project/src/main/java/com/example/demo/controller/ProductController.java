package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.service.ProductService;
import com.example.demo.service.ReviewService;
import com.example.demo.vo.ResultData;
import com.example.demo.vo.Product;
import com.example.demo.vo.ProductReview;
import com.example.demo.vo.Rq;

@Controller
public class ProductController {

    @Autowired
    private ProductService productService;

    @Autowired
    private ReviewService reviewService;

    @Autowired
    private Rq rq;

    /**
     * 상품 목록 페이지로 데이터 전달
     *
     * @param model   모델 객체
     * @param category 카테고리 (선택적)
     * @return 상품 목록 뷰
     */
    @GetMapping("/product/article/list")
    public String showProductList(Model model, @RequestParam(value = "category", required = false) String category) {
        ResultData<List<Product>> productListRd;

        if (category != null && !category.isEmpty()) {
            productListRd = productService.getProductsByCategory(category);
        } else {
            productListRd = productService.getProductList();
        }

        if (productListRd.isFail()) {
            return rq.historyBackOnView(productListRd.getMsg());
        }

        model.addAttribute("productList", productListRd.getData1());
        return "product/article/list";
    }

    /**
     * 특정 상품 상세 정보 페이지 (리뷰 페이지네이션 추가)
     *
     * @param model 모델 객체
     * @param id    상품 ID
     * @param page  현재 페이지 (리뷰 페이지네이션)
     * @return 상품 상세 정보 뷰
     */
    @GetMapping("/product/article/detail")
    public String showProductDetail(Model model, 
                                    @RequestParam("id") int id,
                                    @RequestParam(defaultValue = "1") int page) { // 페이지 파라미터 추가
        // 상품 정보 불러오기
        ResultData<Product> productRd = productService.getProductById(id);

        if (productRd.isFail()) {
            return rq.historyBackOnView(productRd.getMsg());
        }

        // 리뷰 페이지네이션 처리
        int reviewsPerPage = 5; // 한 페이지에 보여줄 리뷰 수
        ResultData<List<ProductReview>> reviewsRd = reviewService.getReviewsByProductIdWithPagination(id, page, reviewsPerPage);

        if (reviewsRd.isFail()) {
            model.addAttribute("reviews", List.of()); // 리뷰가 없을 때 빈 리스트 처리
            model.addAttribute("noReviewsMessage", "아직 리뷰가 없습니다.");
        } else {
            List<ProductReview> reviews = reviewsRd.getData1();
            model.addAttribute("reviews", reviews);

            // 총 리뷰 수 및 전체 페이지 계산
            int totalReviews = reviewService.getTotalReviewCountByProductId(id);
            int totalPages = (int) Math.ceil((double) totalReviews / reviewsPerPage);

            // 페이지네이션 관련 속성 추가
            model.addAttribute("page", page);
            model.addAttribute("totalPages", totalPages);
        }

        // 상품 정보 추가
        model.addAttribute("product", productRd.getData1());
        return "product/article/detail";
    }

    /**
     * 제품 검색
     *
     * @param model   모델 객체
     * @param keyword 검색어
     * @return 검색 결과 뷰
     */
    @GetMapping("/product/search")
    public String searchProducts(Model model, @RequestParam(value = "keyword", required = false) String keyword) {
        if (keyword == null || keyword.isEmpty()) {
            return rq.historyBackOnView("검색어를 입력해 주세요.");
        }

        ResultData<List<Product>> searchResults = productService.searchProducts(keyword);

        if (searchResults.isFail()) {
            return rq.historyBackOnView(searchResults.getMsg());
        }

        // 검색 결과 추가
        model.addAttribute("productList", searchResults.getData1());
        return "product/article/list";
    }
}
