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

    @GetMapping("/product/article/list")
    public String showProductList(Model model, @RequestParam(value = "category", required = false) String category) {
        ResultData<List<Product>> productListRd = (category != null && !category.isEmpty())
                ? productService.getProductsByCategory(category)
                : productService.getProductList();

        if (productListRd.isFail()) {
            return rq.historyBackOnView(productListRd.getMsg());
        }

        model.addAttribute("productList", productListRd.getData1());
        return "product/article/list";
    }

    @GetMapping("/product/article/detail")
    public String showProductDetail(Model model, 
                                    @RequestParam("id") int id,
                                    @RequestParam(defaultValue = "1") int page) {
        ResultData<Product> productRd = productService.getProductById(id);

        if (productRd.isFail()) {
            return rq.historyBackOnView(productRd.getMsg());
        }

        int reviewsPerPage = 5; 
        ResultData<List<ProductReview>> reviewsRd = reviewService.getReviewsByProductIdWithPagination(id, page, reviewsPerPage);

        model.addAttribute("reviews", reviewsRd.isFail() ? List.of() : reviewsRd.getData1());
        if (reviewsRd.isFail()) {
            model.addAttribute("noReviewsMessage", "아직 리뷰가 없습니다.");
        } else {
            int totalReviews = reviewService.getTotalReviewCountByProductId(id);
            int totalPages = (int) Math.ceil((double) totalReviews / reviewsPerPage);

            model.addAttribute("page", page);
            model.addAttribute("totalPages", totalPages);
        }

        model.addAttribute("product", productRd.getData1());
        return "product/article/detail";
    }

    @GetMapping("/product/search")
    public String searchProducts(Model model, @RequestParam(value = "keyword", required = false) String keyword) {
        if (keyword == null || keyword.isEmpty()) {
            return rq.historyBackOnView("검색어를 입력해 주세요.");
        }

        ResultData<List<Product>> searchResults = productService.searchProducts(keyword);

        if (searchResults.isFail()) {
            return rq.historyBackOnView(searchResults.getMsg());
        }

        model.addAttribute("productList", searchResults.getData1());
        return "product/article/list";
    }
}
