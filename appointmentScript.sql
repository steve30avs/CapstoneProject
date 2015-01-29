--DELETE FROM appointments_table;

DECLARE
  @dateStart DATE = GETDATE(),
  @timeStart time(3),
  @workingHours   INT,
  @workingDays    INT,
  @rowCount INT
SELECT
  -- Workday starts at 9am
  @timeStart = '09:00:00',

  -- Prevent booking of same-day appointments
  @dateStart = DATEADD(DAY, 1, @dateStart),
  @workingHours = 0,
  @workingDays = 0

-- Delete dates in the past
DELETE FROM appointments_table WHERE appointment_date < GETDATE();
SET @rowCount = (SELECT COUNT(*) FROM appointments_table)

IF (SELECT COUNT(*) FROM appointments_table) < 280
BEGIN

	-- Make sure date isn't already in table
	IF (SELECT COUNT(*) FROM appointments_table) > 0
	BEGIN
	   SELECT @dateStart = MAX(appointment_date) FROM appointments_table
	   SELECT @dateStart = DATEADD(DAY, @rowCount, @dateStart)
	END
	ELSE

WHILE (@workingDays < 40)

		-- Skip weekends
		IF (SELECT DATEPART(DW,@dateStart)) = 7
			SELECT @dateStart = DATEADD(DAY, 2, @dateStart)
		ELSE IF (SELECT DATEPART(DW,@dateStart)) = 1
			SELECT @dateStart = DATEADD(DAY, 1, @dateStart)
		ELSE

	BEGIN

		WHILE (@workingHours < 7)
		BEGIN
			INSERT INTO appointments_table (appointment_date, appointment_time) VALUES (@dateStart, @timeStart)
			SET @timeStart = DATEADD(HOUR, 1, @timeStart)
			SET @workingHours = @workingHours + 1
		END

		SET @workingHours = 0;
		SET @timeStart = '09:00:00';
		SET @dateStart = DATEADD(DAY, 1, @dateStart)
		SET @workingDays = @workingDays + 1
	END
END