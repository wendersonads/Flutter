package com.develop.dev_api.domain.service;

import com.develop.dev_api.domain.entity.Dev;
import com.develop.dev_api.domain.entity.dto.DevDTO;
import com.develop.dev_api.domain.repository.DevRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class DevService {

    private final DevRepository repository;

    public List<Dev> findAll() {
        return repository.findAll();
    }

    public List<Dev> findAllEnabled() {
        return repository.findAllByEnabled(true);
    }

    public Dev save(DevDTO devDTO) {
        Dev dev = new Dev();
        dev.setName(devDTO.getName());
        dev.setTotal(devDTO.getTotal());
        dev.setDate(devDTO.getDate());
        dev.setUuid(UUID.randomUUID());
        dev.setEnabled(true);
        return repository.save(dev);
    }
}
