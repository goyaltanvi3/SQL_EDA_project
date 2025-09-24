
-- Exploratory data analysis

USE world_layoffs;

SELECT *
FROM layoffs_staging2;

SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT MIN(date), MAX(date)
FROM layoffs_staging2;

SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

SELECT YEAR(date), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(date)
ORDER BY 1 DESC;

SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;


SELECT company, AVG(percentage_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT SUBSTRING(date, 1, 7) AS Month, SUM(total_laid_off)
FROM layoffs_staging2
WHERE  SUBSTRING(date, 1, 7) IS NOT NULL
GROUP BY month
ORDER BY 1 ASC;

SELECT DISTINCT SUBSTRING(date, 1, 7) AS Month,
SUM(total_laid_off) OVER(ORDER BY SUBSTRING(date, 1, 7)) AS layoffs_rolling,
SUM(total_laid_off) OVER(PARTITION BY SUBSTRING(date, 1, 7)) AS total_layoffs
FROM layoffs_staging2
WHERE SUBSTRING(date, 1, 7) IS NOT NULL
ORDER BY 1;

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

 
SELECT company, YEAR(date), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(date)
ORDER BY 3 DESC;

WITH company_year (company, years, total_laid_off) AS
 (
 SELECT company, YEAR(date), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(date)
 ), company_year_rank AS 
(SELECT *,
 DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM company_year
WHERE years IS NOT NULL
)
SELECT *
FROM company_year_rank
WHERE Ranking <= 5;




