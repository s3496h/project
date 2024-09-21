package com.example.demo.service;

import com.example.demo.repository.CartRepository;
import com.example.demo.vo.Cart;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class CartService {

    @Autowired
    private CartRepository cartRepository;

    public List<Cart> getCartItemsByMemberId(int memberId) {
        return cartRepository.getCartItemsByMemberId(memberId);
    }

    public void addToCart(int memberId, int productId, int quantity) {
        cartRepository.addToCart(memberId, productId, quantity);
    }

    public void removeFromCart(int memberId, int productId) {
        cartRepository.removeFromCart(memberId, productId);
    }
}