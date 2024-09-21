package com.example.demo.controller;

import com.example.demo.service.CartService;
import com.example.demo.vo.Cart;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/cart")
public class CartController {

    @Autowired
    private CartService cartService;

    @GetMapping
    public String viewCart(@RequestParam("memberId") int memberId, Model model) {
        List<Cart> cartItems = cartService.getCartItemsByMemberId(memberId);
        model.addAttribute("cartItems", cartItems);
        
        // Total amount 계산
        double totalAmount = cartItems.stream()
                                       .mapToDouble(item -> item.getQuantity() * item.getProductPrice())
                                       .sum();
        model.addAttribute("totalAmount", totalAmount);

        return "cart/view";
    }

    @PostMapping("/add")
    public String addToCart(@RequestParam("memberId") int memberId, 
                            @RequestParam("productId") int productId, 
                            @RequestParam("quantity") int quantity) {
        cartService.addToCart(memberId, productId, quantity);
        return "redirect:/cart?memberId=" + memberId;
    }

    @PostMapping("/remove")
    public String removeFromCart(@RequestParam("memberId") int memberId, 
                                 @RequestParam("productId") int productId) {
        cartService.removeFromCart(memberId, productId);
        return "redirect:/cart?memberId=" + memberId;
    }
}