package com.develop.gpp.domain.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "tags")
public class TagsModel {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id_tag")
    private Long idTag;

    private String nome;

}
