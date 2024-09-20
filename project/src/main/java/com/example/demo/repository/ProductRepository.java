package com.example.demo.repository;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import com.example.demo.vo.Product;
import com.example.demo.vo.ProductReview;

@Mapper
public interface ProductRepository {

    // Fetch all products
    @Select("""
            SELECT *
            FROM product
            ORDER BY id ASC
            """)
    List<Product> getProducts();

    // Fetch a product by ID
    @Select("""
            SELECT *
            FROM product
            WHERE id = #{id}
            """)
    Product getProductById(@Param("id") int id);

    // Fetch product details description by product ID
    @Select("""
            SELECT DESCRIPTION
            FROM product_details
            WHERE product_id = #{id}
            """)
    String getProductDescriptionById(@Param("id") int id);

    // Fetch reviews for a product
    @Select("""
            SELECT *
            FROM product_reviews
            WHERE product_id = #{productId}
            ORDER BY regDate DESC
            """)
    List<ProductReview> getProductReviews(@Param("productId") int productId);

    // Search for products by name
    @Select("""
            SELECT *
            FROM product
            WHERE name LIKE CONCAT('%', #{keyword}, '%') 
            ORDER BY id ASC
            """)
    List<Product> findByNameContaining(@Param("keyword") String keyword);

    // Fetch products by category
    @Select("""
            SELECT *
            FROM product
            WHERE category = #{category}
            ORDER BY id ASC
            """)
    List<Product> findByCategory(@Param("category") String category);

    // Fetch product sizes by product ID
    @Select("""
            SELECT size
            FROM product_sizes
            WHERE product_id = #{id}
            """)
    List<String> getProductSizes(@Param("id") int id);

    // Fetch product colors by product ID
    @Select("""
            SELECT color
            FROM product_colors
            WHERE product_id = #{id}
            """)
    List<String> getProductColors(@Param("id") int id);
    
}