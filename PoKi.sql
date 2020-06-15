-- 1. What grades are stored in the database?
SELECT * FROM Grade;

-- 2. What emotions may be associated with a poem?
SELECT * FROM Emotion;

-- 3. How many poems are in the database?
SELECT
	COUNT(DISTINCT Id) AS "Number of Poems"
FROM Poem

-- 4. Sort authors alphabetically by name. What are the names of the top 76 authors?
SELECT Name
FROM Author
ORDER BY Name

-- 5. Starting with the above query, add the grade of each of the authors.
SELECT
	auth.Name AS "AUTHOR",
	grade.Name AS "GRADE"
FROM Author auth
LEFT JOIN Grade grade ON auth.GradeId = grade.Id
ORDER BY auth.Name

-- 6. Starting with the above query, add the recorded gender of each of the authors.
SELECT
	auth.Name AS "AUTHOR",
	grade.Name AS "GRADE",
	gend.Name AS "GENDER"
FROM Author auth
LEFT JOIN Grade grade ON auth.GradeId = grade.Id
LEFT JOIN Gender gend ON auth.GenderId = gend.Id
ORDER BY auth.Name

-- 7. What is the total number of words in all poems in the database?
SELECT
	SUM(WordCount)
FROM Poem

-- 8. Which poem has the fewest characters?
SELECT 
	MIN(CharCount) AS "LENGTH OF SHORTEST POEM"
FROM Poem

-- 9. How many authors are in the third grade?
SELECT 
	COUNT(DISTINCT Id) AS "# AUTHORS IN 3RD GRADE"
FROM Author
WHERE GradeId = 3

-- 10. How many authors are in the first, second or third grades?
SELECT 
	COUNT(DISTINCT Id) AS "# AUTHORS IN GRADES 1-3"
FROM Author
WHERE GradeId = 1
OR GradeId = 2
OR GradeId = 3

-- 11. What is the total number of poems written by fourth graders?
SELECT 
	COUNT(DISTINCT poem.Id) AS "# POEMS IN 4TH GRADE"
FROM Poem poem
LEFT JOIN Author auth ON poem.AuthorId = auth.Id
WHERE auth.GradeId = 4

-- 12. How many poems are there per grade?
SELECT
	auth.GradeId AS "GRADE",
	COUNT(DISTINCT poem.Id) AS "# POEMS"
FROM Poem poem
LEFT JOIN Author auth ON poem.AuthorId = auth.Id
GROUP BY auth.GradeId
ORDER BY auth.GradeId

-- 13. How many authors are in each grade? (Order your results by grade starting with 1st Grade)
SELECT
	grade.Id AS "GRADE",
	COUNT(DISTINCT auth.Id) AS "# AUTHORS"
FROM Author auth
LEFT JOIN Grade grade ON auth.GradeId = grade.Id
GROUP BY grade.Id
ORDER BY grade.Id

-- 14. What is the title of the poem that has the most words?
SELECT 
	Title
FROM Poem
WHERE WordCount =
	(SELECT MAX(WordCount) FROM Poem)

-- 15. Which author(s) have the most poems? (Remember authors can have the same name.)
SELECT 
	TOP 1 COUNT(poem.Id) AS "POEM COUNT", 
	auth.Name AS "AUTHOR"
FROM Author auth 
JOIN Poem poem ON poem.AuthorId = auth.Id
GROUP BY auth.Name
ORDER BY COUNT(poem.Id) DESC

-- 16. How many poems have an emotion of sadness?
SELECT 
	COUNT(PoemId) AS "# SADNESS POEMS"
FROM PoemEmotion 
WHERE EmotionId = 3
	
-- 17. How many poems are not associated with any emotion?
SELECT
	COUNT(PoemId) AS "POEMS W/NO EMOTION"
FROM PoemEmotion 
WHERE EmotionId IS NULL

-- 18. Which emotion is associated with the least number of poems?
SELECT 
	TOP 1 COUNT(poEmot.PoemId) AS "POEM COUNT", 
	emot.Name AS "EMOTION WITH FEWEST POEMS"
FROM PoemEmotion poEmot
LEFT JOIN Poem poem ON poEmot.PoemId = poem.Id
LEFT JOIN Emotion emot ON poEmot.EmotionId = emot.Id
GROUP BY emot.Name
ORDER BY COUNT(poEmot.poemId) ASC

-- 19. Which grade has the largest number of poems with an emotion of joy?




-- 20. Which gender has the least number of poems with an emotion of fear?