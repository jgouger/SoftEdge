CREATE OR ALTER PROCEDURE CreateMember
(
	@Name varchar(512),
	@district varchar(50),
	@state varchar(50),
	@party varchar(50),
	@picture  varchar(1024) = null,
	@chamber varchar(50)
)

AS
SET NOCOUNT ON;

IF (NOT EXISTS (SELECT 1 FROM members WHERE Name = @Name AND chamber = @chamber))
BEGIN
	INSERT INTO members
	(
		Name, district, state, party, picture, chamber
	)
	VALUES
	(
		@Name, @district, @state, @party, @Picture, @chamber
	);
END