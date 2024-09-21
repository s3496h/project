package com.example.demo.repository;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Delete;
import java.util.List;
import com.example.demo.vo.Cart;

@Mapper
public interface CartRepository {

    @Select("""
            SELECT C.*, P.name AS productName, P.price AS productPrice, 
                   (P.price * C.quantity) AS totalPrice  -- totalPrice 계산
            FROM cart AS C
            INNER JOIN product AS P
            ON C.productId = P.id
            WHERE C.memberId = #{memberId}
            ORDER BY C.id ASC;
            """)
    List<Cart> getCartItemsByMemberId(int memberId);

    @Insert("""
            INSERT INTO cart
            SET regDate = NOW(),
            memberId = #{memberId},
            productId = #{product_id},
            quantity = #{quantity};
            """)
    void addToCart(int memberId, int product_id, int quantity);

    @Delete("""
            DELETE FROM cart
            WHERE memberId = #{memberId}
            AND productId = #{product_id};
            """)
    void removeFromCart(int memberId, int product_id);
}