# Snack Automat from Group 2502

## Vending Machine Concept with Dart/Flutter

This document outlines a basic concept for a snack vending machine application using Dart and Flutter. It focuses on the core components and functionalities for cash-only transactions.

## 1. Introduction

A snack vending machine application built with Flutter that simulates the process of selecting snacks, inserting coins, and dispensing items. The interface is designed for touch-screen operation with simple, intuitive controls.

## 2. Core Features

**Product Display**: Grid layout showing available snacks with names, prices, and images
**Product Selection**: Touch-based selection with visual feedback
**Cash Payment**: Coin insertion simulation (10¢, 20¢, 50¢, 1€, 2€)
**Change Calculation**: Automatic calculation and dispensing of correct change
**Dispensing Feedback**: Visual animation and confirmation message
**Basic Inventory**: Track product quantities and show "SOLD OUT" status

## 3. User Interface Layout

```
┌─────────────────────┬─────────────┐
│                     │ Inserted:   │
│   Product Grid      │ €0.00       │
│   (Snacks Display)  │             │
│                     │ Price:      │
│                     │ €0.00       │
│                     │             │
│                     │ Coin Buttons│
│                     │ [10¢][20¢]  │
│                     │ [50¢][1€]   │
│                     │ [2€]        │
│                     │             │
│                     │ Change:     │
│                     │ €0.00       │
└─────────────────────┴─────────────┘
```

## 4. Technology Stack

**Language**: Dart  
**Framework**: Flutter  
**State Management**: Provider or simple setState  
**UI Design**: Material Design with custom styling  
**Platform**: Mobile-first design

## 5. Basic Workflow

1. User views available snacks
2. User selects desired snack (price displays)
3. User inserts coins until sufficient amount reached
4. Machine dispenses snack and change (if any)
5. Transaction complete, ready for next customer

## 6. Simple Features Only

- Cash payments only (no cards)
- Basic coin denominations
- Simple product grid
- Essential change calculation
- Basic inventory tracking

This concept focuses on core vending machine functionality without complex payment systems, making it perfect for learning Flutter layouts and basic state management.