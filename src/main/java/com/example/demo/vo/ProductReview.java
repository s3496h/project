package com.example.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProductReview {
    private int id; // 리뷰 ID
    private int productId; // 상품 ID
    private String content; // 리뷰 내용
    private String nickname; // 작성자 닉네임
    private int rating; // 평점
    private String regDate; // 등록일
    private boolean userCanModify; // 수정 권한
    private boolean userCanDelete; // 삭제 권한
    private int memberId; // 작성자 ID
    private String extra__writer;

    // 추가 생성자 (nickname, memberId 포함)
    public ProductReview(int id, int productId, String content, String nickname, int rating, String regDate, int memberId) {
        this.id = id;
        this.productId = productId;
        this.content = content;
        this.nickname = nickname;
        this.rating = rating;
        this.regDate = regDate;
        this.userCanModify = false; // 기본값 설정
        this.userCanDelete = false; // 기본값 설정
        this.memberId = memberId;
    }
}