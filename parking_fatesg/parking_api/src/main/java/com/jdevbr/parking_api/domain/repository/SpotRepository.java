package com.jdevbr.parking_api.domain.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.jdevbr.parking_api.domain.entity.Spot;
import com.jdevbr.parking_api.domain.enums.Status;

@Repository
public interface SpotRepository extends JpaRepository<Spot, Long> {
    
    Optional<Spot> findByPlateAndStatus(String plate, Status status);

    List<Spot> findAllByPlate(String plate);

    List<Spot> findAllByStatus(Status status);
}
