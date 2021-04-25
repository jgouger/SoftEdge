USE [master]
GO

/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [congress]    Script Date: 4/25/2021 4:49:18 PM ******/
CREATE LOGIN [congress] WITH PASSWORD=N'0LrB/q57oU28a7dsL5GsOF+OBSjKflZ0W9lLdXsBtBk=', DEFAULT_DATABASE=[Congress], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO

USE [Congress]
GO

/****** Object:  User [congress]    Script Date: 4/25/2021 4:48:29 PM ******/
CREATE USER [congress] FOR LOGIN [congress] WITH DEFAULT_SCHEMA=[dbo]
GO