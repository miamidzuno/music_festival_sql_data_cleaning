# Music Festivals - Data Cleaning Project

## Overview
Data cleaning project on a Music Festivals dataset using MySQL.
The main challenge was handling corrupted unicode currency symbols
that couldn't be matched with standard LIKE queries.

## Dataset
Source: Music Festivals Dataset (Kaggle)
Rows: 205

## What I Cleaned
- Fixed column names and structure
- Renamed merged column attendance_age → age_range
- Identified corrupted currency symbols using HEX() function
- Extracted clean currency column (GBP, EUR, USD, AUD, DKK)
- Extracted numeric values into clean amount_millions column
- Dropped original messy economic_impact column

## The Interesting Part
Standard LIKE queries couldn't match the broken € and £ symbols.
Had to use HEX() to read actual byte codes, then CHAR() hex values
to match and replace them correctly.

## Tools Used
- MySQL / MySQL Workbench

## Files
- `festivals_cleaning.sql` - Full cleaning script with comments
