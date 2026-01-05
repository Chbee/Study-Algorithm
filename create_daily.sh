#!/bin/bash

# 사용법: ./create_daily.sh 1 1 (Week1 Day1)

WEEK=$1
DAY=$2
DATE=$(date +%Y-%m-%d)

WEEK_DIR="Week${WEEK}"
DAY_DIR="${WEEK_DIR}/Day${DAY}"

# README 생성
cat > ${DAY_DIR}/README.md << TEMPLATE
# Day ${DAY} - 

## 📅 학습 날짜
${DATE}

## 🎯 학습 목표
- [ ] 

## 📚 학습 내용

### 푼 문제
| 문제 | 난이도 | 상태 | 소요시간 | 링크 |
|------|--------|------|----------|------|
|  |  |  |  |  |

## 💡 배운 점
-

## ⚠️ 어려웠던 점
-

## 📝 복습 필요
- [ ] 

## ⏱️ 학습 시간
- 이론: 
- 문제풀이: 
- **총: 4시간**
TEMPLATE

echo "✅ Created: ${DAY_DIR}/README.md"
