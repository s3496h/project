package com.example.demo.controller;

import com.example.demo.service.ReviewService;
import com.example.demo.service.ProductService; // ProductService 추가
import com.example.demo.util.Ut;
import com.example.demo.vo.Member;
import com.example.demo.vo.Product;
import com.example.demo.vo.ProductReview;
import com.example.demo.vo.ResultData;
import com.example.demo.vo.Rq;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.ui.Model;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class ReviewController {

    @Autowired
    private Rq rq;

    @Autowired
    private ReviewService reviewService;

    @Autowired
    private ProductService productService; // ProductService 주입

    @RequestMapping("/usr/review/doWrite")
    @ResponseBody
    public String doWrite(HttpServletRequest req, int productId, String content, int rating) {
        if (Ut.isEmptyOrNull(content)) {
            return Ut.jsHistoryBack("F-2", "내용을 입력해주세요");
        }

        Member loggedInMember = rq.getLoginedMember();
        if (loggedInMember == null) {
            return Ut.jsHistoryBack("F-3", "로그인이 필요합니다");
        }

        String nickname = loggedInMember.getNickname();
        ResultData<ProductReview> writeReviewRd = reviewService.addReview(loggedInMember.getId(), productId, content, nickname, rating);
        return Ut.jsReplace(writeReviewRd.getResultCode(), writeReviewRd.getMsg(), "/product/article/detail?id=" + productId);
    }

    @RequestMapping("/usr/review/doModify")
    @ResponseBody
    public String doModify(HttpServletRequest req, int id, String content, int rating) {
        ProductReview review = reviewService.getProductReview(id);
        if (review == null) {
            return Ut.jsHistoryBack("F-1", Ut.f("%d번 리뷰는 존재하지 않습니다", id));
        }

        ResultData loginedMemberCanModifyRd = reviewService.userCanModify(rq.getLoginedMemberId(), review);
        if (loginedMemberCanModifyRd.isSuccess()) {
            reviewService.modifyProductReview(id, content, rating);
        }

        return review.getContent(); // 수정된 리뷰의 내용을 반환
    }

    // 제품 상세 페이지 메서드 추가
    @RequestMapping("/product/article/detail")
    public String getProductDetail(int id, Model model) {
        // 제품 정보를 가져옵니다.
    	ResultData<Product> productData = productService.getProductById(id);
    	if (!productData.isSuccess()) {
    	    return "error"; // 오류 처리
    	}
    	Product product = productData.getData1();
    	model.addAttribute("product", product);

        return "product/detail"; // JSP 파일 경로
    }
}