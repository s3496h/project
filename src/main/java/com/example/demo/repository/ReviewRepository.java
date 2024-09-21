package com.example.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.demo.vo.ProductReview;

@Mapper
public interface ReviewRepository {

    @Select("""
            SELECT R.*, M.nickname AS extra__writer
            FROM product_reviews AS R
            INNER JOIN member AS M ON R.memberId = M.id
            WHERE R.productId = #{productId}
            ORDER BY R.id ASC
            LIMIT #{offset}, #{limit}
            """)
    List<ProductReview> getForPrintProductReviews(int productId, int offset, int limit);

    @Select("""
            SELECT COUNT(*) FROM product_reviews WHERE productId = #{productId}
            """)
    int getTotalReviewCountByProductId(int productId);

    @Insert("""
            INSERT INTO product_reviews
            (regDate, memberId, productId, content, rating)
            VALUES (NOW(), #{memberId}, #{productId}, #{content}, #{rating})
            """)
    void writeProductReview(int memberId, int productId, String content, int rating);

    @Select("SELECT LAST_INSERT_ID();")
    int getLastInsertId();

    @Select("""
            SELECT R.*
            FROM product_reviews AS R
            WHERE R.id = #{id}
            """)
    ProductReview getProductReview(int id);

    @Update("""
            UPDATE product_reviews
            SET content = #{content}, rating = #{rating}
            WHERE id = #{id}
            """)
    void modifyProductReview(int id, String content, int rating);
}