package com.mariadb.todo.domain;

import jakarta.persistence.*;

import lombok.Data;

@Data
@Entity
@Table(name = "tasks")
public class Task {
    @Id 
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String description;
    private Boolean completed = false;
}