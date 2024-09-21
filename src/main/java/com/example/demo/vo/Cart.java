package com.example.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Cart {
    private int id;
    private int memberId;
    private int productId;
    private int quantity;
    private String productName;
    private int productPrice;

    // totalPrice 계산을 위한 getter 메서드 추가
    public int getTotalPrice() {
        return quantity * productPrice; // quantity와 productPrice를 곱하여 totalPrice 계산
    }
}