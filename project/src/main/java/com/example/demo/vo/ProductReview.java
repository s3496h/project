package com.example.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProductReview {
    private int id;
    private LocalDateTime regDate; // String에서 LocalDateTime으로 변경
    private LocalDateTime updateDate; // String에서 LocalDateTime으로 변경
    private int productId;
    private String userName; // 작성자의 로그인 ID
    private String content;
    private int rating;
    private String writerNickname; // 작성자의 닉네임 추가
}