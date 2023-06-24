package com.develop.dev_api.domain.repository;

import com.develop.dev_api.domain.entity.Dev;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DevRepository extends JpaRepository<Dev, Long> {

    List<Dev> findAllByEnabled(boolean enabled);
}
