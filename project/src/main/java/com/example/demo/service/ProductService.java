package com.example.demo.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.example.demo.repository.ProductRepository;
import com.example.demo.vo.ResultData;
import com.example.demo.vo.ProductReview;
import com.example.demo.vo.Product;

@Service
public class ProductService {

    @Autowired
    private ProductRepository productRepository;

    // 전체 상품 목록을 조회하여 ResultData로 반환
    public ResultData<List<Product>> getProductList() {
        List<Product> productList = productRepository.getProducts();

        if (productList.isEmpty()) {
            return ResultData.from("F-1", "상품이 존재하지 않습니다.");
        }

        return ResultData.from("S-1", "상품 목록을 불러왔습니다.", "productList", productList);
    }

    public ResultData<Product> getProductById(int id) {
        try {
            Product product = productRepository.getProductById(id);

            if (product == null) {
                return ResultData.from("F-2", "해당 상품을 찾을 수 없습니다.");
            }

            // 설명 추가
            String description = productRepository.getProductDescriptionById(id);
            product.setDescription(description);

            // 사이즈, 색상, 리뷰 추가
            setProductDetails(product, id);

            return ResultData.from("S-2", "상품 정보를 불러왔습니다.", "product", product);
        } catch (Exception e) {
            return ResultData.from("F-5", "오류가 발생했습니다: " + e.getMessage());
        }
    }

    private void setProductDetails(Product product, int id) {
        List<String> sizes = productRepository.getProductSizes(id);
        List<String> colors = productRepository.getProductColors(id);
        List<ProductReview> reviews = productRepository.getProductReviews(id);

        product.setSizes(sizes);
        product.setColors(colors);
        product.setReviews(reviews);
    }

    // 상품 검색
    public ResultData<List<Product>> searchProducts(String keyword) {
        List<Product> searchResults = productRepository.findByNameContaining(keyword);

        if (searchResults.isEmpty()) {
            return ResultData.from("F-3", "검색 결과가 없습니다.");
        }

        return ResultData.from("S-3", "검색 결과를 불러왔습니다.", "searchResults", searchResults);
    }

    // 카테고리별 상품 조회
    public ResultData<List<Product>> getProductsByCategory(String category) {
        List<Product> productList = productRepository.findByCategory(category);

        if (productList.isEmpty()) {
            return ResultData.from("F-4", "해당 카테고리의 상품이 존재하지 않습니다.");
        }

        return ResultData.from("S-4", "카테고리별 상품 목록을 불러왔습니다.", "productList", productList);
    }
    
}