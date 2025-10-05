using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace ezSCORES.Services.Migrations
{
    /// <inheritdoc />
    public partial class DataSeed : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "City",
                columns: new[] { "Id", "CreatedAt", "IsActive", "IsDeleted", "ModifiedAt", "Name", "RemovedAt" },
                values: new object[,]
                {
                    { 1, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "Mostar", null },
                    { 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "Sarajevo", null },
                    { 3, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "Tuzla", null },
                    { 4, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "Zenica", null },
                    { 5, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "Banja Luka", null },
                    { 6, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "Bihać", null },
                    { 7, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "Trebinje", null },
                    { 8, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "Goražde", null },
                    { 9, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "Konjic", null },
                    { 10, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "Čapljina", null },
                    { 11, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "Stolac", null }
                });

            migrationBuilder.InsertData(
                table: "Player",
                columns: new[] { "Id", "BirthDate", "CreatedAt", "FirstName", "IsActive", "IsDeleted", "LastName", "ModifiedAt", "Picture", "RemovedAt" },
                values: new object[,]
                {
                    { 1, new DateTime(1979, 5, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Amir", true, false, "Hadžić", null, null, null },
                    { 2, new DateTime(1981, 2, 28, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Senad", true, false, "Suljić", null, null, null },
                    { 3, new DateTime(1983, 8, 3, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Nermin", true, false, "Delić", null, null, null },
                    { 4, new DateTime(1976, 11, 17, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Samir", true, false, "Hodžić", null, null, null },
                    { 5, new DateTime(1982, 4, 9, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Almir", true, false, "Mujić", null, null, null },
                    { 6, new DateTime(1978, 1, 30, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Mirsad", true, false, "Karić", null, null, null },
                    { 7, new DateTime(1974, 10, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Ismet", true, false, "Begović", null, null, null },
                    { 8, new DateTime(1984, 6, 19, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Sanel", true, false, "Osmanović", null, null, null },
                    { 9, new DateTime(1980, 7, 11, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Zlatan", true, false, "Džafić", null, null, null },
                    { 10, new DateTime(1975, 3, 8, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Faruk", true, false, "Halilović", null, null, null },
                    { 11, new DateTime(1985, 12, 21, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Jasmin", true, false, "Bajrić", null, null, null },
                    { 12, new DateTime(1977, 5, 10, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Mirza", true, false, "Bešić", null, null, null },
                    { 13, new DateTime(1983, 2, 17, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Enes", true, false, "Alihodžić", null, null, null },
                    { 14, new DateTime(1980, 6, 23, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Haris", true, false, "Smajić", null, null, null },
                    { 15, new DateTime(1979, 9, 29, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Adnan", true, false, "Šabanović", null, null, null },
                    { 16, new DateTime(1982, 11, 2, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Dino", true, false, "Kurtović", null, null, null },
                    { 17, new DateTime(1984, 4, 4, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Elvir", true, false, "Hasić", null, null, null },
                    { 18, new DateTime(1976, 12, 13, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Sabahudin", true, false, "Mehić", null, null, null },
                    { 19, new DateTime(1978, 8, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Armin", true, false, "Mustafić", null, null, null },
                    { 20, new DateTime(1983, 1, 27, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Ermin", true, false, "Hadžiomerović", null, null, null },
                    { 21, new DateTime(2006, 3, 14, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Tarik", true, false, "Zukić", null, null, null },
                    { 22, new DateTime(2005, 7, 9, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Kenan", true, false, "Musić", null, null, null },
                    { 23, new DateTime(2007, 11, 30, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Emin", true, false, "Alić", null, null, null },
                    { 24, new DateTime(2004, 5, 3, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Ajdin", true, false, "Hasić", null, null, null },
                    { 25, new DateTime(2006, 1, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Arman", true, false, "Hadžović", null, null, null },
                    { 26, new DateTime(2008, 4, 6, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Ismail", true, false, "Topić", null, null, null },
                    { 27, new DateTime(2005, 9, 17, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Edin", true, false, "Memić", null, null, null },
                    { 28, new DateTime(2007, 12, 22, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Faris", true, false, "Omerović", null, null, null },
                    { 29, new DateTime(2006, 8, 10, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Nedim", true, false, "Zulić", null, null, null },
                    { 30, new DateTime(2005, 2, 8, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Haris", true, false, "Mušanović", null, null, null },
                    { 31, new DateTime(2008, 7, 19, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Omar", true, false, "Beglerović", null, null, null },
                    { 32, new DateTime(2007, 9, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Amar", true, false, "Delić", null, null, null },
                    { 33, new DateTime(2006, 3, 21, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Emir", true, false, "Kozlica", null, null, null },
                    { 34, new DateTime(2004, 11, 13, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Adin", true, false, "Šehić", null, null, null },
                    { 35, new DateTime(2007, 5, 28, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Riad", true, false, "Karić", null, null, null },
                    { 36, new DateTime(2005, 6, 30, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Benjamin", true, false, "Hasanović", null, null, null },
                    { 37, new DateTime(2006, 9, 9, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Eldar", true, false, "Bećirović", null, null, null },
                    { 38, new DateTime(2008, 10, 18, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Tarik", true, false, "Selimović", null, null, null },
                    { 39, new DateTime(2004, 12, 3, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Arnel", true, false, "Muratović", null, null, null },
                    { 40, new DateTime(2007, 1, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Kenan", true, false, "Bešlagić", null, null, null },
                    { 41, new DateTime(1993, 5, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Haris", true, false, "Kovačević", null, null, null },
                    { 42, new DateTime(1997, 9, 2, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Dino", true, false, "Babić", null, null, null },
                    { 43, new DateTime(1999, 3, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Alen", true, false, "Mujić", null, null, null },
                    { 44, new DateTime(1990, 1, 9, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Adis", true, false, "Halilović", null, null, null },
                    { 45, new DateTime(1995, 11, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Nedžad", true, false, "Kapić", null, null, null },
                    { 46, new DateTime(1998, 2, 22, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Mirza", true, false, "Begović", null, null, null },
                    { 47, new DateTime(1992, 7, 3, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Elvis", true, false, "Mehić", null, null, null },
                    { 48, new DateTime(1990, 10, 14, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Adnan", true, false, "Salihović", null, null, null },
                    { 49, new DateTime(1996, 9, 9, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Amar", true, false, "Ćosić", null, null, null },
                    { 50, new DateTime(1994, 6, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Faruk", true, false, "Hadžialić", null, null, null },
                    { 51, new DateTime(1991, 3, 27, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Emir", true, false, "Alić", null, null, null },
                    { 52, new DateTime(1999, 7, 19, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Jasmin", true, false, "Suljić", null, null, null },
                    { 53, new DateTime(1993, 8, 8, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Almir", true, false, "Husić", null, null, null },
                    { 54, new DateTime(1998, 10, 2, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Eldin", true, false, "Zulić", null, null, null },
                    { 55, new DateTime(1990, 12, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Armin", true, false, "Bajrić", null, null, null },
                    { 56, new DateTime(1995, 1, 11, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Edin", true, false, "Karić", null, null, null },
                    { 57, new DateTime(1992, 4, 22, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Nermin", true, false, "Smajlović", null, null, null },
                    { 58, new DateTime(1993, 11, 30, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Dženan", true, false, "Hadžiabdić", null, null, null },
                    { 59, new DateTime(1989, 9, 17, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Saša", true, false, "Kovačević", null, null, null },
                    { 60, new DateTime(1994, 5, 9, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Arnel", true, false, "Subašić", null, null, null },
                    { 61, new DateTime(1997, 2, 4, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Selmir", true, false, "Bešić", null, null, null },
                    { 62, new DateTime(1996, 6, 21, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Tarik", true, false, "Hadžiselimović", null, null, null },
                    { 63, new DateTime(1999, 9, 12, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Kenan", true, false, "Karišik", null, null, null },
                    { 64, new DateTime(1993, 7, 18, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Edis", true, false, "Ramić", null, null, null },
                    { 65, new DateTime(1991, 3, 30, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Dževad", true, false, "Ćosić", null, null, null },
                    { 66, new DateTime(1994, 8, 14, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Adis", true, false, "Šehić", null, null, null },
                    { 67, new DateTime(1992, 10, 19, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Eldar", true, false, "Omeragić", null, null, null },
                    { 68, new DateTime(1998, 1, 26, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Armin", true, false, "Begić", null, null, null },
                    { 69, new DateTime(1996, 12, 7, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Amar", true, false, "Hodžić", null, null, null },
                    { 70, new DateTime(1990, 11, 25, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Benjamin", true, false, "Delić", null, null, null },
                    { 71, new DateTime(1995, 5, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Elmin", true, false, "Šabanović", null, null, null },
                    { 72, new DateTime(1992, 3, 10, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Tarik", true, false, "Hasanović", null, null, null },
                    { 73, new DateTime(1991, 1, 29, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Haris", true, false, "Mešić", null, null, null },
                    { 74, new DateTime(1994, 7, 16, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Selver", true, false, "Kurtović", null, null, null },
                    { 75, new DateTime(1998, 4, 23, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Adnan", true, false, "Bećiragić", null, null, null },
                    { 76, new DateTime(1990, 9, 28, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Edin", true, false, "Selimović", null, null, null },
                    { 77, new DateTime(1996, 5, 2, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Nedim", true, false, "Hadžihasanović", null, null, null },
                    { 78, new DateTime(1993, 8, 11, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Alen", true, false, "Ćehajić", null, null, null },
                    { 79, new DateTime(1992, 2, 20, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Haris", true, false, "Beširović", null, null, null },
                    { 80, new DateTime(1995, 12, 4, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Eldin", true, false, "Muratović", null, null, null },
                    { 81, new DateTime(1999, 3, 9, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Emin", true, false, "Mujanović", null, null, null },
                    { 82, new DateTime(1993, 10, 27, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Dino", true, false, "Avdić", null, null, null },
                    { 83, new DateTime(1997, 11, 30, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Sanel", true, false, "Hadžibegić", null, null, null },
                    { 84, new DateTime(1996, 1, 19, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Kenan", true, false, "Mušanović", null, null, null },
                    { 85, new DateTime(1994, 4, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Aldin", true, false, "Smajlović", null, null, null },
                    { 86, new DateTime(1998, 9, 22, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Adis", true, false, "Burić", null, null, null },
                    { 87, new DateTime(1995, 6, 13, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Faris", true, false, "Karić", null, null, null },
                    { 88, new DateTime(1991, 10, 9, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Emir", true, false, "Hasić", null, null, null },
                    { 89, new DateTime(1997, 12, 15, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Jasmin", true, false, "Bečić", null, null, null },
                    { 90, new DateTime(1994, 8, 7, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Ermin", true, false, "Alihodžić", null, null, null },
                    { 91, new DateTime(1993, 9, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Mirza", true, false, "Šabanagić", null, null, null },
                    { 92, new DateTime(1995, 5, 11, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Edis", true, false, "Mujić", null, null, null },
                    { 93, new DateTime(1990, 1, 23, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Dženis", true, false, "Hadžimuratović", null, null, null },
                    { 94, new DateTime(1999, 10, 30, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Almin", true, false, "Kapo", null, null, null },
                    { 95, new DateTime(1996, 7, 26, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Tarik", true, false, "Zulić", null, null, null },
                    { 96, new DateTime(1997, 3, 5, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Eldar", true, false, "Šehić", null, null, null },
                    { 97, new DateTime(1991, 8, 13, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Adnan", true, false, "Begović", null, null, null },
                    { 98, new DateTime(1999, 12, 29, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Haris", true, false, "Halilović", null, null, null },
                    { 99, new DateTime(1992, 6, 24, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Nermin", true, false, "Osmanović", null, null, null },
                    { 100, new DateTime(1994, 2, 17, 0, 0, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Dino", true, false, "Ramić", null, null, null }
                });

            migrationBuilder.InsertData(
                table: "Referee",
                columns: new[] { "Id", "CreatedAt", "FirstName", "IsActive", "IsDeleted", "LastName", "ModifiedAt", "Picture", "RemovedAt" },
                values: new object[,]
                {
                    { 1, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Adnan", true, false, "Karić", null, null, null },
                    { 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Emir", true, false, "Husić", null, null, null },
                    { 3, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Nermin", true, false, "Zukić", null, null, null },
                    { 4, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Haris", true, false, "Šehić", null, null, null },
                    { 5, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Almir", true, false, "Begić", null, null, null },
                    { 6, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Senad", true, false, "Jahić", null, null, null },
                    { 7, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Mirza", true, false, "Dedić", null, null, null },
                    { 8, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Edin", true, false, "Mujić", null, null, null },
                    { 9, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Sead", true, false, "Halilović", null, null, null },
                    { 10, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Damir", true, false, "Salihović", null, null, null },
                    { 11, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Mirsad", true, false, "Brkić", null, null, null },
                    { 12, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Ermin", true, false, "Ibrahimović", null, null, null },
                    { 13, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Faruk", true, false, "Hadžiosmanović", null, null, null },
                    { 14, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Armin", true, false, "Hodžić", null, null, null },
                    { 15, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Tarik", true, false, "Softić", null, null, null },
                    { 16, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Samir", true, false, "Bubalo", null, null, null },
                    { 17, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Muamer", true, false, "Topić", null, null, null },
                    { 18, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Nedim", true, false, "Alihodžić", null, null, null },
                    { 19, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Elvis", true, false, "Selimović", null, null, null },
                    { 20, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Jasmin", true, false, "Bešlija", null, null, null }
                });

            migrationBuilder.InsertData(
                table: "Role",
                columns: new[] { "Id", "CreatedAt", "Description", "IsActive", "IsDeleted", "ModifiedAt", "Name", "RemovedAt" },
                values: new object[,]
                {
                    { 1, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Creating tournaments and managing", true, false, null, "Organizer", null },
                    { 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Managing teams and participating on competitions", true, false, null, "Manager", null },
                    { 3, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "System administrator, has all privileges in the system", true, false, null, "Admin", null },
                    { 4, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Spectates competitions, rates and reviews them", true, false, null, "Manager", null }
                });

            migrationBuilder.InsertData(
                table: "Selection",
                columns: new[] { "Id", "AgeMax", "CreatedAt", "IsActive", "IsDeleted", "ModifiedAt", "Name", "RemovedAt" },
                values: new object[,]
                {
                    { 1, 21, new DateTime(2025, 2, 2, 0, 0, 0, 0, DateTimeKind.Unspecified), true, false, new DateTime(2025, 4, 28, 23, 5, 21, 0, DateTimeKind.Unspecified), "U-21", null },
                    { 2, null, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), true, false, new DateTime(2025, 3, 7, 0, 54, 51, 0, DateTimeKind.Unspecified), "Seniori", null },
                    { 3, 19, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), true, false, null, "U-19", null },
                    { 4, 17, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), true, false, null, "U-17", null },
                    { 5, 15, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), true, false, null, "U-15", null },
                    { 6, 13, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), true, false, null, "U-13", null },
                    { 7, 11, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), true, false, null, "U-11", null },
                    { 8, 9, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), true, false, null, "U-9", null },
                    { 9, 7, new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), true, false, null, "U-7", null },
                    { 10, null, new DateTime(2025, 3, 7, 1, 13, 40, 0, DateTimeKind.Unspecified), true, false, null, "Veterani", null },
                    { 11, 5, new DateTime(2025, 4, 28, 23, 1, 34, 0, DateTimeKind.Unspecified), true, false, null, "U-5", null },
                    { 12, 23, new DateTime(2025, 4, 28, 23, 5, 32, 0, DateTimeKind.Unspecified), true, false, null, "U-23", null }
                });

            migrationBuilder.InsertData(
                table: "Sponsors",
                columns: new[] { "Id", "CreatedAt", "IsActive", "IsDeleted", "ModifiedAt", "Name", "Picture", "RemovedAt" },
                values: new object[,]
                {
                    { 1, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "BH Telecom", null, null },
                    { 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "HT Eronet", null, null },
                    { 3, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "Vijeće Grada Mostara", null, null },
                    { 4, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "ASA Banka", null, null },
                    { 5, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "Sparkasse Bank BiH", null, null },
                    { 6, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "Addiko Bank", null, null },
                    { 7, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "UniCredit Bank", null, null },
                    { 8, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "Raiffeisen Bank", null, null },
                    { 9, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "Sarajevski Kiseljak", null, null },
                    { 10, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "Oaza Natural Water", null, null },
                    { 11, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "Sarajevska Pivara", null, null },
                    { 12, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "Bingo d.o.o.", null, null },
                    { 13, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "DM Drogerie Markt", null, null },
                    { 14, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "Mercator BH", null, null },
                    { 15, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "Konzum BiH", null, null },
                    { 16, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "Elektroprivreda BiH", null, null },
                    { 17, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "NLB Banka", null, null },
                    { 18, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "Centrotrans", null, null },
                    { 19, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "Bosnalijek", null, null },
                    { 20, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "Prevent Group", null, null }
                });

            migrationBuilder.InsertData(
                table: "Stadium",
                columns: new[] { "Id", "CreatedAt", "IsActive", "IsDeleted", "ModifiedAt", "Name", "Picture", "RemovedAt" },
                values: new object[,]
                {
                    { 1, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "Sportska dvorana Skenderija", null, null },
                    { 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "Dvorana Mirza Delibašić Sarajevo", null, null },
                    { 3, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "Gradska dvorana Tuzla", null, null },
                    { 4, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "Dvorana Mejdan Tuzla", null, null },
                    { 5, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "Sportska dvorana Pecara Široki Brijeg", null, null },
                    { 6, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "Dvorana Mladost Zenica", null, null },
                    { 7, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "Gradska arena Zenica", null, null },
                    { 8, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "Dvorana Borik Banja Luka", null, null },
                    { 9, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "Dvorana Obilićevo Banja Luka", null, null },
                    { 10, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "Sportska dvorana Mostar", null, null },
                    { 11, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "Dvorana Bijeli Brijeg Mostar", null, null },
                    { 12, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "Gradska dvorana Trebinje", null, null },
                    { 13, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "Dvorana Luke Bihać", null, null },
                    { 14, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "Sportska dvorana Livno", null, null },
                    { 15, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "Sportska dvorana Gornji Vakuf-Uskoplje", null, null },
                    { 16, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "Dvorana Kakanj", null, null },
                    { 17, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "Sportska dvorana Jablanica", null, null },
                    { 18, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "Dvorana Novo Sarajevo", null, null },
                    { 19, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "Dvorana Čapljina", null, null },
                    { 20, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "Sportska dvorana Živinice", null, null }
                });

            migrationBuilder.InsertData(
                table: "User",
                columns: new[] { "Id", "CreatedAt", "Email", "FirstName", "IsActive", "IsDeleted", "LastName", "ModifiedAt", "Organization", "PasswordHash", "PasswordSalt", "PhoneNumber", "Picture", "RemovedAt", "RoleId", "UserName" },
                values: new object[,]
                {
                    { 1, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "cevraensar@ezscores.ba", "Ensar", true, false, "Čevra", null, null, "M7zEJ+DYWDwhK9xe5h3QpSFXK9w=", "q83k3u3B9nZrV2l4Qwh0+Q==", "+38761000111", null, null, 3, "cevraensar" },
                    { 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "mirza.kovacevic@ezscores.ba", "Mirza", true, false, "Kovačević", null, null, "M7zEJ+DYWDwhK9xe5h3QpSFXK9w=", "q83k3u3B9nZrV2l4Qwh0+Q==", "+38761000222", null, null, 1, "mirzakovacevic" },
                    { 3, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "ensar.cevra@ezscores.ba", "Ensar", true, false, "Čevra", null, null, "M7zEJ+DYWDwhK9xe5h3QpSFXK9w=", "q83k3u3B9nZrV2l4Qwh0+Q==", "+38761000222", null, null, 1, "ensarcevra" },
                    { 4, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "elmin.hadziosmanovic@ezscores.ba", "Elmin", true, false, "Hadžiosmanović", null, null, "M7zEJ+DYWDwhK9xe5h3QpSFXK9w=", "q83k3u3B9nZrV2l4Qwh0+Q==", "+38761000333", null, null, 2, "elminhadziosmanovic" },
                    { 5, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "nermin.karic@ezscores.ba", "Nermin", true, false, "Karić", null, null, "M7zEJ+DYWDwhK9xe5h3QpSFXK9w=", "q83k3u3B9nZrV2l4Qwh0+Q==", "+38761000444", null, null, 2, "nerminkaric" },
                    { 6, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "selma.muratovic@ezscores.ba", "Selma", true, false, "Muratović", null, null, "M7zEJ+DYWDwhK9xe5h3QpSFXK9w=", "q83k3u3B9nZrV2l4Qwh0+Q==", "+38761000555", null, null, 4, "selmamuratovic" }
                });

            migrationBuilder.InsertData(
                table: "Competition",
                columns: new[] { "Id", "ApplicationEndDate", "CityId", "CompetitionType", "CreatedAt", "Description", "Fee", "IsActive", "IsDeleted", "MaxPlayersPerTeam", "MaxTeamCount", "ModifiedAt", "Name", "Picture", "RemovedAt", "Season", "SelectionId", "StartDate", "Status", "UserId" },
                values: new object[,]
                {
                    { 1, new DateTime(2025, 10, 13, 14, 30, 0, 0, DateTimeKind.Unspecified), 2, 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Tradicionalna zimska futsal liga koja okuplja najbolje timove iz Sarajeva i okoline.", 100, true, false, 15, 16, null, "Zimska Liga Sarajevo", null, null, "2025/2026", 2, new DateTime(2025, 10, 14, 14, 30, 0, 0, DateTimeKind.Unspecified), 2, 2 },
                    { 2, new DateTime(2025, 10, 25, 14, 30, 0, 0, DateTimeKind.Unspecified), 1, 1, new DateTime(2025, 9, 9, 14, 30, 0, 0, DateTimeKind.Unspecified), "Kup takmičenje u Mostaru poznato po uzbudljivim utakmicama i sjajnoj atmosferi.", 80, true, false, 12, 16, null, "Futsal Kup Mostar", null, null, "2025/2026", 2, new DateTime(2025, 11, 5, 14, 30, 0, 0, DateTimeKind.Unspecified), 3, 3 },
                    { 3, new DateTime(2025, 10, 13, 14, 30, 0, 0, DateTimeKind.Unspecified), 3, 2, new DateTime(2025, 9, 29, 14, 30, 0, 0, DateTimeKind.Unspecified), "Proljetno futsal prvenstvo Tuzle za amatere i poluprofesionalce do 21 godine.", 120, true, false, 15, 10, null, "Proljetna Liga Tuzla U21", null, null, "2025/2026", 1, new DateTime(2025, 10, 14, 14, 30, 0, 0, DateTimeKind.Unspecified), 2, 2 },
                    { 4, new DateTime(2025, 10, 13, 14, 30, 0, 0, DateTimeKind.Unspecified), 4, 1, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Popularni ljetni turnir u Zenici koji svake godine privlači veliki broj ekipa i gledalaca.", 150, true, false, 12, 20, null, "Ljetni Turnir Zenica", null, null, "2025/2026", 2, new DateTime(2025, 10, 14, 14, 30, 0, 0, DateTimeKind.Unspecified), 1, 3 },
                    { 5, new DateTime(2025, 10, 13, 14, 30, 0, 0, DateTimeKind.Unspecified), 11, 0, new DateTime(2025, 9, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), "Noćni turnir koji se igra pod reflektorima — spoj sporta, muzike i dobre zabave.", 200, false, false, 12, 8, null, "Futsal Kup Stolac", null, null, "2025/2026", 2, new DateTime(2025, 10, 14, 14, 30, 0, 0, DateTimeKind.Unspecified), 5, 3 }
                });

            migrationBuilder.InsertData(
                table: "Team",
                columns: new[] { "Id", "CreatedAt", "IsActive", "IsDeleted", "ModifiedAt", "Name", "Picture", "RemovedAt", "SelectionId", "UserId" },
                values: new object[,]
                {
                    { 1, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "MNK Lavovi Sarajevo", null, null, 1, 4 },
                    { 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "MNK Vitezovi Zenica", null, null, 2, 4 },
                    { 3, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "MNK Borci Mostar", null, null, 3, 4 },
                    { 4, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "MNK Pobjeda Tuzla", null, null, 4, 4 },
                    { 5, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "MNK Sloga Banja Luka", null, null, 5, 4 },
                    { 6, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "MNK Olimp Ilidža", null, null, 6, 4 },
                    { 7, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "MNK Tempo Bihać", null, null, 7, 4 },
                    { 8, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "MNK Stijena Livno", null, null, 8, 4 },
                    { 9, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "MNK Energija Kakanj", null, null, 9, 4 },
                    { 10, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "MNK Fortuna Goražde", null, null, 10, 4 },
                    { 11, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "MNK Korner Trebinje", null, null, 11, 5 },
                    { 12, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "MNK Delta Čapljina", null, null, 12, 5 },
                    { 13, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "MNK Željezno Srce Živinice", null, null, 1, 5 },
                    { 14, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "MNK Horizont Gradačac", null, null, 2, 5 },
                    { 15, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "MNK Bljesak Sanski Most", null, null, 3, 5 },
                    { 16, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "MNK Olimpik Jablanica", null, null, 4, 5 },
                    { 17, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "MNK Tornado Visoko", null, null, 5, 5 },
                    { 18, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "MNK Bosna Uskoplje", null, null, 6, 5 },
                    { 19, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "MNK Mladost Lukavac", null, null, 7, 5 },
                    { 20, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "MNK Union Travnik", null, null, 8, 5 }
                });

            migrationBuilder.InsertData(
                table: "Application",
                columns: new[] { "Id", "CompetitionId", "CreatedAt", "IsAccepted", "IsActive", "IsDeleted", "IsPaId", "Message", "ModifiedAt", "PaIdAmount", "RemovedAt", "TeamId" },
                values: new object[,]
                {
                    { 1, 1, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, true, false, true, "Prijava tima", null, 100f, null, 1 },
                    { 2, 1, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, true, false, true, "Prijava tima", null, 100f, null, 2 },
                    { 3, 1, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, true, false, true, "Prijava tima", null, 100f, null, 3 },
                    { 4, 1, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, true, false, true, "Prijava tima", null, 100f, null, 4 },
                    { 5, 1, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), false, true, false, false, "Prijava tima", null, null, null, 5 },
                    { 6, 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, true, false, true, "Prijava tima", null, 80f, null, 1 },
                    { 7, 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, true, false, true, "Prijava tima", null, 80f, null, 2 },
                    { 8, 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, true, false, true, "Prijava tima", null, 80f, null, 3 },
                    { 9, 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, true, false, true, "Prijava tima", null, 80f, null, 4 },
                    { 10, 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, true, false, true, "Prijava tima", null, 80f, null, 5 },
                    { 11, 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, true, false, true, "Prijava tima", null, 80f, null, 6 },
                    { 12, 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, true, false, true, "Prijava tima", null, 80f, null, 7 },
                    { 13, 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, true, false, true, "Prijava tima", null, 80f, null, 8 },
                    { 14, 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, true, false, true, "Prijava tima", null, 80f, null, 9 },
                    { 15, 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, true, false, true, "Prijava tima", null, 80f, null, 10 },
                    { 16, 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, true, false, true, "Prijava tima", null, 80f, null, 11 },
                    { 17, 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, true, false, true, "Prijava tima", null, 80f, null, 12 },
                    { 18, 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, true, false, true, "Prijava tima", null, 80f, null, 13 },
                    { 19, 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, true, false, true, "Prijava tima", null, 80f, null, 14 },
                    { 20, 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, true, false, true, "Prijava tima", null, 80f, null, 15 },
                    { 21, 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, true, false, true, "Prijava tima", null, 80f, null, 16 },
                    { 22, 3, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), false, true, false, false, "Prijava tima", null, null, null, 17 },
                    { 23, 3, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), false, true, false, false, "Prijava tima", null, null, null, 18 },
                    { 24, 3, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), false, true, false, false, "Prijava tima", null, null, null, 19 },
                    { 25, 3, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), false, true, false, false, "Prijava tima", null, null, null, 20 },
                    { 26, 5, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, true, false, true, "Prijava tima", null, 200f, null, 1 },
                    { 27, 5, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, true, false, true, "Prijava tima", null, 200f, null, 2 },
                    { 28, 5, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, true, false, true, "Prijava tima", null, 200f, null, 3 },
                    { 29, 5, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, true, false, true, "Prijava tima", null, 200f, null, 4 },
                    { 30, 5, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, true, false, true, "Prijava tima", null, 200f, null, 5 },
                    { 31, 5, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, true, false, true, "Prijava tima", null, 200f, null, 6 },
                    { 32, 5, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, true, false, true, "Prijava tima", null, 200f, null, 7 },
                    { 33, 5, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, true, false, true, "Prijava tima", null, 200f, null, 8 }
                });

            migrationBuilder.InsertData(
                table: "CompetitionsReferees",
                columns: new[] { "Id", "CompetitionId", "CreatedAt", "IsActive", "IsDeleted", "ModifiedAt", "RefereeId", "RemovedAt" },
                values: new object[,]
                {
                    { 1, 1, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, 1, null },
                    { 2, 1, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, 2, null },
                    { 3, 1, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, 3, null },
                    { 4, 1, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, 4, null },
                    { 5, 1, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, 5, null },
                    { 6, 1, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, 6, null },
                    { 7, 1, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, 7, null },
                    { 8, 1, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, 8, null },
                    { 9, 1, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, 9, null },
                    { 10, 2, new DateTime(2025, 9, 28, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, 10, null },
                    { 11, 2, new DateTime(2025, 9, 28, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, 11, null },
                    { 12, 2, new DateTime(2025, 9, 28, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, 12, null },
                    { 13, 2, new DateTime(2025, 9, 28, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, 13, null },
                    { 14, 2, new DateTime(2025, 9, 28, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, 14, null },
                    { 15, 2, new DateTime(2025, 9, 28, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, 15, null },
                    { 16, 3, new DateTime(2025, 9, 30, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, 16, null },
                    { 17, 3, new DateTime(2025, 9, 30, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, 17, null },
                    { 18, 5, new DateTime(2025, 10, 2, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, 10, null },
                    { 19, 5, new DateTime(2025, 10, 2, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, 11, null },
                    { 20, 5, new DateTime(2025, 10, 2, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, 12, null },
                    { 21, 5, new DateTime(2025, 10, 2, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, 13, null },
                    { 22, 5, new DateTime(2025, 10, 2, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, 14, null },
                    { 23, 5, new DateTime(2025, 10, 2, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, 15, null },
                    { 24, 5, new DateTime(2025, 10, 2, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, 16, null },
                    { 25, 5, new DateTime(2025, 10, 2, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, 17, null },
                    { 26, 5, new DateTime(2025, 10, 2, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, 18, null },
                    { 27, 5, new DateTime(2025, 10, 2, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, 19, null },
                    { 28, 5, new DateTime(2025, 10, 2, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, 20, null }
                });

            migrationBuilder.InsertData(
                table: "CompetitionsSponsors",
                columns: new[] { "Id", "CompetitionId", "CreatedAt", "IsActive", "IsDeleted", "ModifiedAt", "RemovedAt", "SponsorId", "Type" },
                values: new object[,]
                {
                    { 1, 1, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, null, 1, null },
                    { 2, 1, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, null, 2, null },
                    { 3, 1, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, null, 3, null },
                    { 4, 1, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, null, 4, null },
                    { 5, 1, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, null, 5, null },
                    { 6, 2, new DateTime(2025, 9, 28, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, null, 6, null },
                    { 7, 2, new DateTime(2025, 9, 28, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, null, 7, null },
                    { 8, 2, new DateTime(2025, 9, 28, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, null, 8, null },
                    { 9, 2, new DateTime(2025, 9, 28, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, null, 9, null },
                    { 10, 3, new DateTime(2025, 9, 30, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, null, 10, null },
                    { 11, 3, new DateTime(2025, 9, 30, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, null, 11, null },
                    { 12, 5, new DateTime(2025, 10, 2, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, null, 12, null },
                    { 13, 5, new DateTime(2025, 10, 2, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, null, 13, null },
                    { 14, 5, new DateTime(2025, 10, 2, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, null, 14, null },
                    { 15, 5, new DateTime(2025, 10, 2, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, null, 15, null },
                    { 16, 5, new DateTime(2025, 10, 2, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, null, 16, null }
                });

            migrationBuilder.InsertData(
                table: "CompetitionsTeams",
                columns: new[] { "Id", "CompetitionId", "CreatedAt", "GroupId", "IsActive", "IsDeleted", "IsEliminated", "ModifiedAt", "RemovedAt", "TeamId" },
                values: new object[,]
                {
                    { 22, 3, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), null, true, false, false, null, null, 17 },
                    { 23, 3, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), null, true, false, false, null, null, 18 },
                    { 24, 3, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), null, true, false, false, null, null, 19 },
                    { 25, 3, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), null, true, false, false, null, null, 20 },
                    { 26, 5, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), null, true, false, false, null, null, 1 },
                    { 27, 5, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), null, true, false, false, null, null, 2 },
                    { 28, 5, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), null, true, false, false, null, null, 3 },
                    { 29, 5, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), null, true, false, false, null, null, 4 },
                    { 30, 5, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), null, true, false, false, null, null, 5 },
                    { 31, 5, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), null, true, false, false, null, null, 6 },
                    { 32, 5, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), null, true, false, false, null, null, 7 },
                    { 33, 5, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), null, true, false, false, null, null, 8 }
                });

            migrationBuilder.InsertData(
                table: "FavoriteCompetitions",
                columns: new[] { "Id", "CompetitionId", "CreatedAt", "IsActive", "IsDeleted", "ModifiedAt", "RemovedAt", "UserId" },
                values: new object[,]
                {
                    { 1, 1, new DateTime(2025, 9, 29, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, null, 4 },
                    { 2, 2, new DateTime(2025, 9, 29, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, null, 4 },
                    { 3, 3, new DateTime(2025, 9, 29, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, null, 5 },
                    { 4, 5, new DateTime(2025, 9, 29, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, null, 6 }
                });

            migrationBuilder.InsertData(
                table: "Fixture",
                columns: new[] { "Id", "CompetitionId", "CreatedAt", "GameStage", "IsActive", "IsCompleted", "IsCurrentlyActive", "IsDeleted", "MatchLength", "ModifiedAt", "RemovedAt", "SequenceNumber" },
                values: new object[,]
                {
                    { 1, 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, false, false, 15, null, null, 1 },
                    { 2, 5, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 2, true, true, false, false, 20, null, null, 0 },
                    { 3, 5, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 3, true, true, false, false, 20, null, null, 0 },
                    { 4, 5, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 5, true, true, false, false, 20, null, null, 0 }
                });

            migrationBuilder.InsertData(
                table: "Group",
                columns: new[] { "Id", "CompetitionId", "CreatedAt", "IsActive", "IsDeleted", "ModifiedAt", "Name", "RemovedAt" },
                values: new object[,]
                {
                    { 1, 1, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "Zimska Liga Sarajevo", null },
                    { 2, 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "Group A", null },
                    { 3, 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "Group B", null },
                    { 4, 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "Group C", null },
                    { 5, 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, "Group D", null }
                });

            migrationBuilder.InsertData(
                table: "Review",
                columns: new[] { "Id", "CompetitionId", "CreatedAt", "IsActive", "IsDeleted", "ModifiedAt", "Rating", "RemovedAt", "UserId" },
                values: new object[,]
                {
                    { 1, 5, new DateTime(2025, 10, 3, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, 4.5f, null, 4 },
                    { 2, 5, new DateTime(2025, 10, 3, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, 3.8f, null, 5 },
                    { 3, 5, new DateTime(2025, 10, 3, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, null, 5f, null, 6 }
                });

            migrationBuilder.InsertData(
                table: "Reward",
                columns: new[] { "Id", "Amount", "CompetitionId", "CreatedAt", "Description", "IsActive", "IsDeleted", "ModifiedAt", "Name", "RankingPosition", "RemovedAt" },
                values: new object[,]
                {
                    { 1, 500, 1, new DateTime(2025, 9, 27, 14, 30, 0, 0, DateTimeKind.Unspecified), "Nagrada za prvo mjesto", true, false, null, "Prvo mjesto", 1, null },
                    { 2, 300, 1, new DateTime(2025, 9, 27, 14, 30, 0, 0, DateTimeKind.Unspecified), "Nagrada za drugo mjesto", true, false, null, "Drugo mjesto", 2, null },
                    { 3, 150, 1, new DateTime(2025, 9, 27, 14, 30, 0, 0, DateTimeKind.Unspecified), "Nagrada za treće mjesto", true, false, null, "Treće mjesto", 3, null },
                    { 4, 600, 2, new DateTime(2025, 9, 28, 14, 30, 0, 0, DateTimeKind.Unspecified), "Nagrada za prvo mjesto", true, false, null, "Prvo mjesto", 1, null },
                    { 5, 350, 2, new DateTime(2025, 9, 28, 14, 30, 0, 0, DateTimeKind.Unspecified), "Nagrada za drugo mjesto", true, false, null, "Drugo mjesto", 2, null },
                    { 6, 200, 2, new DateTime(2025, 9, 28, 14, 30, 0, 0, DateTimeKind.Unspecified), "Nagrada za treće mjesto", true, false, null, "Treće mjesto", 3, null },
                    { 7, 700, 3, new DateTime(2025, 9, 29, 14, 30, 0, 0, DateTimeKind.Unspecified), "Nagrada za prvo mjesto", true, false, null, "Prvo mjesto", 1, null },
                    { 8, 400, 3, new DateTime(2025, 9, 29, 14, 30, 0, 0, DateTimeKind.Unspecified), "Nagrada za drugo mjesto", true, false, null, "Drugo mjesto", 2, null },
                    { 9, 250, 3, new DateTime(2025, 9, 29, 14, 30, 0, 0, DateTimeKind.Unspecified), "Nagrada za treće mjesto", true, false, null, "Treće mjesto", 3, null },
                    { 10, 800, 5, new DateTime(2025, 10, 2, 14, 30, 0, 0, DateTimeKind.Unspecified), "Nagrada za prvo mjesto", true, false, null, "Prvo mjesto", 1, null },
                    { 11, 450, 5, new DateTime(2025, 10, 2, 14, 30, 0, 0, DateTimeKind.Unspecified), "Nagrada za drugo mjesto", true, false, null, "Drugo mjesto", 2, null },
                    { 12, 300, 5, new DateTime(2025, 10, 2, 14, 30, 0, 0, DateTimeKind.Unspecified), "Nagrada za treće mjesto", true, false, null, "Treće mjesto", 3, null }
                });

            migrationBuilder.InsertData(
                table: "CompetitionsTeams",
                columns: new[] { "Id", "CompetitionId", "CreatedAt", "GroupId", "IsActive", "IsDeleted", "IsEliminated", "ModifiedAt", "RemovedAt", "TeamId" },
                values: new object[,]
                {
                    { 1, 1, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 1, true, false, false, null, null, 1 },
                    { 2, 1, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 1, true, false, false, null, null, 2 },
                    { 3, 1, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 1, true, false, false, null, null, 3 },
                    { 4, 1, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 1, true, false, false, null, null, 4 },
                    { 5, 1, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 1, true, false, false, null, null, 5 },
                    { 6, 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 2, true, false, false, null, null, 1 },
                    { 7, 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 2, true, false, false, null, null, 2 },
                    { 8, 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 2, true, false, false, null, null, 3 },
                    { 9, 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 2, true, false, false, null, null, 4 },
                    { 10, 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 3, true, false, false, null, null, 5 },
                    { 11, 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 3, true, false, false, null, null, 6 },
                    { 12, 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 3, true, false, false, null, null, 7 },
                    { 13, 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 3, true, false, false, null, null, 8 },
                    { 14, 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 4, true, false, false, null, null, 9 },
                    { 15, 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 4, true, false, false, null, null, 10 },
                    { 16, 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 4, true, false, false, null, null, 11 },
                    { 17, 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 4, true, false, false, null, null, 12 },
                    { 18, 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 5, true, false, false, null, null, 13 },
                    { 19, 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 5, true, false, false, null, null, 14 },
                    { 20, 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 5, true, false, false, null, null, 15 },
                    { 21, 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 5, true, false, false, null, null, 16 }
                });

            migrationBuilder.InsertData(
                table: "CompetitionsTeamsPlayers",
                columns: new[] { "Id", "CompetitionsTeamsId", "CreatedAt", "GoalsTotal", "IsActive", "IsDeleted", "IsVerified", "ModifiedAt", "PlayerId", "RemovedAt" },
                values: new object[,]
                {
                    { 115, 26, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 15, null },
                    { 116, 26, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 16, null },
                    { 117, 26, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 17, null },
                    { 118, 26, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 18, null },
                    { 119, 26, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 19, null },
                    { 120, 26, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 20, null },
                    { 121, 27, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 21, null },
                    { 122, 27, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 22, null },
                    { 123, 27, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 23, null },
                    { 124, 27, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 24, null },
                    { 125, 27, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 25, null },
                    { 126, 28, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 26, null },
                    { 127, 28, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 27, null },
                    { 128, 28, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 28, null },
                    { 129, 28, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 29, null },
                    { 130, 28, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 30, null },
                    { 131, 28, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 31, null },
                    { 132, 28, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 32, null },
                    { 133, 29, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 33, null },
                    { 134, 29, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 34, null },
                    { 135, 29, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 35, null },
                    { 136, 29, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 36, null },
                    { 137, 29, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 37, null },
                    { 138, 29, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 38, null },
                    { 139, 30, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 39, null },
                    { 140, 30, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 40, null },
                    { 141, 30, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 41, null },
                    { 142, 30, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 42, null },
                    { 143, 30, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 43, null },
                    { 144, 31, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 44, null },
                    { 145, 31, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 45, null },
                    { 146, 31, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 46, null },
                    { 147, 31, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 47, null },
                    { 148, 31, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 48, null },
                    { 149, 31, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 49, null },
                    { 150, 32, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 50, null },
                    { 151, 32, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 51, null },
                    { 152, 32, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 52, null },
                    { 153, 32, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 53, null },
                    { 154, 32, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 54, null },
                    { 155, 33, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 55, null },
                    { 156, 33, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 56, null },
                    { 157, 33, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 57, null },
                    { 158, 33, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 58, null },
                    { 159, 33, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 59, null },
                    { 160, 33, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 60, null },
                    { 161, 33, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 61, null }
                });

            migrationBuilder.InsertData(
                table: "Match",
                columns: new[] { "Id", "AwayTeamId", "CreatedAt", "DateAndTime", "FixtureId", "HomeTeamId", "IsActive", "IsCompleted", "IsCompletedInRegullarTime", "IsCurrentlyActive", "IsDeleted", "IsUnderway", "ModifiedAt", "RemovedAt", "StadiumId", "WinnerId" },
                values: new object[,]
                {
                    { 3, 27, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 8, 12, 20, 30, 0, 0, DateTimeKind.Unspecified), 2, 26, true, true, true, false, false, false, null, null, 1, 26 },
                    { 4, 29, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 8, 12, 21, 30, 0, 0, DateTimeKind.Unspecified), 2, 28, true, true, true, false, false, false, null, null, 2, 28 },
                    { 5, 31, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 8, 13, 20, 30, 0, 0, DateTimeKind.Unspecified), 2, 30, true, true, true, false, false, false, null, null, 3, 30 },
                    { 6, 33, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 8, 13, 20, 30, 0, 0, DateTimeKind.Unspecified), 2, 32, true, true, true, false, false, false, null, null, 4, 32 },
                    { 7, 28, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 8, 13, 20, 30, 0, 0, DateTimeKind.Unspecified), 3, 26, true, true, true, false, false, false, null, null, 1, 26 },
                    { 8, 32, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 8, 13, 20, 30, 0, 0, DateTimeKind.Unspecified), 3, 30, true, true, true, false, false, false, null, null, 2, 30 },
                    { 9, 30, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 8, 13, 20, 30, 0, 0, DateTimeKind.Unspecified), 4, 26, true, true, true, false, false, false, null, null, 1, 26 }
                });

            migrationBuilder.InsertData(
                table: "CompetitionsRefereesMatch",
                columns: new[] { "Id", "CompetitionsRefereesId", "CreatedAt", "IsActive", "IsDeleted", "MatchId", "ModifiedAt", "RemovedAt" },
                values: new object[,]
                {
                    { 5, 18, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, 3, null, null },
                    { 6, 19, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, 3, null, null },
                    { 7, 20, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, 4, null, null },
                    { 8, 21, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, 4, null, null },
                    { 9, 22, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, 5, null, null },
                    { 10, 23, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, 5, null, null },
                    { 11, 24, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, 6, null, null },
                    { 12, 25, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, 6, null, null },
                    { 13, 26, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, 7, null, null },
                    { 14, 27, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, 7, null, null },
                    { 15, 28, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, 8, null, null },
                    { 16, 18, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, 8, null, null },
                    { 17, 19, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, 9, null, null },
                    { 18, 20, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, 9, null, null }
                });

            migrationBuilder.InsertData(
                table: "CompetitionsTeamsPlayers",
                columns: new[] { "Id", "CompetitionsTeamsId", "CreatedAt", "GoalsTotal", "IsActive", "IsDeleted", "IsVerified", "ModifiedAt", "PlayerId", "RemovedAt" },
                values: new object[,]
                {
                    { 1, 1, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 1, null },
                    { 2, 1, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 2, null },
                    { 3, 1, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 3, null },
                    { 4, 1, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 4, null },
                    { 5, 1, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 5, null },
                    { 6, 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 6, null },
                    { 7, 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 7, null },
                    { 8, 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 8, null },
                    { 9, 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 9, null },
                    { 10, 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 10, null },
                    { 11, 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 11, null },
                    { 12, 3, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 12, null },
                    { 13, 3, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 13, null },
                    { 14, 3, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 14, null },
                    { 15, 3, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 15, null },
                    { 16, 3, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 16, null },
                    { 17, 4, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 17, null },
                    { 18, 4, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 18, null },
                    { 19, 4, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 19, null },
                    { 20, 4, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 20, null },
                    { 21, 4, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 21, null },
                    { 22, 4, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 22, null },
                    { 23, 5, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 23, null },
                    { 24, 5, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 24, null },
                    { 25, 5, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 25, null },
                    { 26, 5, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 26, null },
                    { 27, 5, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 27, null },
                    { 28, 6, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 28, null },
                    { 29, 6, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 29, null },
                    { 30, 6, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 30, null },
                    { 31, 6, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 31, null },
                    { 32, 6, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 32, null },
                    { 33, 6, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 33, null },
                    { 34, 7, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 34, null },
                    { 35, 7, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 35, null },
                    { 36, 7, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 36, null },
                    { 37, 7, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 37, null },
                    { 38, 7, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 38, null },
                    { 39, 7, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 39, null },
                    { 40, 8, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 40, null },
                    { 41, 8, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 41, null },
                    { 42, 8, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 42, null },
                    { 43, 8, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 43, null },
                    { 44, 8, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 44, null },
                    { 45, 9, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 45, null },
                    { 46, 9, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 46, null },
                    { 47, 9, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 47, null },
                    { 48, 9, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 48, null },
                    { 49, 9, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 49, null },
                    { 50, 9, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 50, null },
                    { 51, 9, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 51, null },
                    { 52, 10, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 52, null },
                    { 53, 10, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 53, null },
                    { 54, 10, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 54, null },
                    { 55, 10, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 55, null },
                    { 56, 10, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 56, null },
                    { 57, 11, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 57, null },
                    { 58, 11, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 58, null },
                    { 59, 11, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 59, null },
                    { 60, 11, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 60, null },
                    { 61, 11, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 61, null },
                    { 62, 11, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 62, null },
                    { 63, 12, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 63, null },
                    { 64, 12, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 64, null },
                    { 65, 12, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 65, null },
                    { 66, 12, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 66, null },
                    { 67, 12, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 67, null },
                    { 68, 13, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 68, null },
                    { 69, 13, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 69, null },
                    { 70, 13, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 70, null },
                    { 71, 13, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 71, null },
                    { 72, 13, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 72, null },
                    { 73, 13, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 73, null },
                    { 74, 14, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 74, null },
                    { 75, 14, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 75, null },
                    { 76, 14, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 76, null },
                    { 77, 14, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 77, null },
                    { 78, 14, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 78, null },
                    { 79, 15, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 79, null },
                    { 80, 15, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 80, null },
                    { 81, 15, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 81, null },
                    { 82, 15, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 82, null },
                    { 83, 15, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 83, null },
                    { 84, 15, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 84, null },
                    { 85, 15, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 85, null },
                    { 86, 16, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 86, null },
                    { 87, 16, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 87, null },
                    { 88, 16, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 88, null },
                    { 89, 16, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 89, null },
                    { 90, 16, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 90, null },
                    { 91, 16, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 91, null },
                    { 92, 17, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 92, null },
                    { 93, 17, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 93, null },
                    { 94, 17, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 94, null },
                    { 95, 17, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 95, null },
                    { 96, 17, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 96, null },
                    { 97, 18, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 97, null },
                    { 98, 18, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 98, null },
                    { 99, 18, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 99, null },
                    { 100, 18, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 100, null },
                    { 101, 18, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 1, null },
                    { 102, 18, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 2, null },
                    { 103, 19, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 3, null },
                    { 104, 19, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 4, null },
                    { 105, 19, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 5, null },
                    { 106, 19, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 6, null },
                    { 107, 19, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 7, null },
                    { 108, 20, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 8, null },
                    { 109, 20, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 9, null },
                    { 110, 20, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 10, null },
                    { 111, 20, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 11, null },
                    { 112, 20, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 12, null },
                    { 113, 20, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 13, null },
                    { 114, 20, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 14, null }
                });

            migrationBuilder.InsertData(
                table: "Goal",
                columns: new[] { "Id", "CompetitionTeamPlayerId", "CreatedAt", "IsActive", "IsDeleted", "IsHomeGoal", "MatchId", "ModifiedAt", "RemovedAt", "ScoredAtMinute", "SequenceNumber" },
                values: new object[,]
                {
                    { 1, 115, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, true, 3, null, null, 2, 1 },
                    { 2, 116, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, true, 3, null, null, 7, 2 },
                    { 3, 117, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, true, 3, null, null, 12, 3 },
                    { 4, 121, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, false, 3, null, null, 15, 4 },
                    { 5, 126, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, true, 4, null, null, 1, 1 },
                    { 6, 127, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, true, 4, null, null, 6, 2 },
                    { 7, 128, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, true, 4, null, null, 11, 3 },
                    { 8, 133, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, false, 4, null, null, 17, 4 },
                    { 9, 139, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, true, 5, null, null, 3, 1 },
                    { 10, 140, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, true, 5, null, null, 8, 2 },
                    { 11, 144, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, false, 5, null, null, 14, 3 },
                    { 12, 150, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, true, 6, null, null, 2, 1 },
                    { 13, 151, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, true, 6, null, null, 9, 2 },
                    { 14, 155, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, false, 6, null, null, 16, 3 },
                    { 15, 115, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, true, 7, null, null, 4, 1 },
                    { 16, 126, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, false, 7, null, null, 10, 2 },
                    { 17, 139, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, true, 8, null, null, 5, 1 },
                    { 18, 150, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, false, 8, null, null, 12, 2 },
                    { 19, 115, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, true, 9, null, null, 3, 1 },
                    { 20, 139, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, false, 9, null, null, 15, 2 }
                });

            migrationBuilder.InsertData(
                table: "Match",
                columns: new[] { "Id", "AwayTeamId", "CreatedAt", "DateAndTime", "FixtureId", "HomeTeamId", "IsActive", "IsCompleted", "IsCompletedInRegullarTime", "IsCurrentlyActive", "IsDeleted", "IsUnderway", "ModifiedAt", "RemovedAt", "StadiumId", "WinnerId" },
                values: new object[,]
                {
                    { 1, 2, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 10, 20, 30, 0, 0, DateTimeKind.Unspecified), 1, 1, true, false, true, false, false, false, null, null, 1, 1 },
                    { 2, 4, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), new DateTime(2025, 10, 10, 21, 30, 0, 0, DateTimeKind.Unspecified), 1, 3, true, false, true, false, false, false, null, null, 2, 3 }
                });

            migrationBuilder.InsertData(
                table: "CompetitionsRefereesMatch",
                columns: new[] { "Id", "CompetitionsRefereesId", "CreatedAt", "IsActive", "IsDeleted", "MatchId", "ModifiedAt", "RemovedAt" },
                values: new object[,]
                {
                    { 1, 10, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, 1, null, null },
                    { 2, 11, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, 1, null, null },
                    { 3, 12, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, 2, null, null },
                    { 4, 13, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), true, false, 2, null, null }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Application",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Application",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Application",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Application",
                keyColumn: "Id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Application",
                keyColumn: "Id",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Application",
                keyColumn: "Id",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Application",
                keyColumn: "Id",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Application",
                keyColumn: "Id",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "Application",
                keyColumn: "Id",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "Application",
                keyColumn: "Id",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "Application",
                keyColumn: "Id",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "Application",
                keyColumn: "Id",
                keyValue: 12);

            migrationBuilder.DeleteData(
                table: "Application",
                keyColumn: "Id",
                keyValue: 13);

            migrationBuilder.DeleteData(
                table: "Application",
                keyColumn: "Id",
                keyValue: 14);

            migrationBuilder.DeleteData(
                table: "Application",
                keyColumn: "Id",
                keyValue: 15);

            migrationBuilder.DeleteData(
                table: "Application",
                keyColumn: "Id",
                keyValue: 16);

            migrationBuilder.DeleteData(
                table: "Application",
                keyColumn: "Id",
                keyValue: 17);

            migrationBuilder.DeleteData(
                table: "Application",
                keyColumn: "Id",
                keyValue: 18);

            migrationBuilder.DeleteData(
                table: "Application",
                keyColumn: "Id",
                keyValue: 19);

            migrationBuilder.DeleteData(
                table: "Application",
                keyColumn: "Id",
                keyValue: 20);

            migrationBuilder.DeleteData(
                table: "Application",
                keyColumn: "Id",
                keyValue: 21);

            migrationBuilder.DeleteData(
                table: "Application",
                keyColumn: "Id",
                keyValue: 22);

            migrationBuilder.DeleteData(
                table: "Application",
                keyColumn: "Id",
                keyValue: 23);

            migrationBuilder.DeleteData(
                table: "Application",
                keyColumn: "Id",
                keyValue: 24);

            migrationBuilder.DeleteData(
                table: "Application",
                keyColumn: "Id",
                keyValue: 25);

            migrationBuilder.DeleteData(
                table: "Application",
                keyColumn: "Id",
                keyValue: 26);

            migrationBuilder.DeleteData(
                table: "Application",
                keyColumn: "Id",
                keyValue: 27);

            migrationBuilder.DeleteData(
                table: "Application",
                keyColumn: "Id",
                keyValue: 28);

            migrationBuilder.DeleteData(
                table: "Application",
                keyColumn: "Id",
                keyValue: 29);

            migrationBuilder.DeleteData(
                table: "Application",
                keyColumn: "Id",
                keyValue: 30);

            migrationBuilder.DeleteData(
                table: "Application",
                keyColumn: "Id",
                keyValue: 31);

            migrationBuilder.DeleteData(
                table: "Application",
                keyColumn: "Id",
                keyValue: 32);

            migrationBuilder.DeleteData(
                table: "Application",
                keyColumn: "Id",
                keyValue: 33);

            migrationBuilder.DeleteData(
                table: "City",
                keyColumn: "Id",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "City",
                keyColumn: "Id",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "City",
                keyColumn: "Id",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "City",
                keyColumn: "Id",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "City",
                keyColumn: "Id",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "City",
                keyColumn: "Id",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "Competition",
                keyColumn: "Id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "CompetitionsReferees",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "CompetitionsReferees",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "CompetitionsReferees",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "CompetitionsReferees",
                keyColumn: "Id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "CompetitionsReferees",
                keyColumn: "Id",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "CompetitionsReferees",
                keyColumn: "Id",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "CompetitionsReferees",
                keyColumn: "Id",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "CompetitionsReferees",
                keyColumn: "Id",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "CompetitionsReferees",
                keyColumn: "Id",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "CompetitionsReferees",
                keyColumn: "Id",
                keyValue: 14);

            migrationBuilder.DeleteData(
                table: "CompetitionsReferees",
                keyColumn: "Id",
                keyValue: 15);

            migrationBuilder.DeleteData(
                table: "CompetitionsReferees",
                keyColumn: "Id",
                keyValue: 16);

            migrationBuilder.DeleteData(
                table: "CompetitionsReferees",
                keyColumn: "Id",
                keyValue: 17);

            migrationBuilder.DeleteData(
                table: "CompetitionsRefereesMatch",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "CompetitionsRefereesMatch",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "CompetitionsRefereesMatch",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "CompetitionsRefereesMatch",
                keyColumn: "Id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "CompetitionsRefereesMatch",
                keyColumn: "Id",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "CompetitionsRefereesMatch",
                keyColumn: "Id",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "CompetitionsRefereesMatch",
                keyColumn: "Id",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "CompetitionsRefereesMatch",
                keyColumn: "Id",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "CompetitionsRefereesMatch",
                keyColumn: "Id",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "CompetitionsRefereesMatch",
                keyColumn: "Id",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "CompetitionsRefereesMatch",
                keyColumn: "Id",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "CompetitionsRefereesMatch",
                keyColumn: "Id",
                keyValue: 12);

            migrationBuilder.DeleteData(
                table: "CompetitionsRefereesMatch",
                keyColumn: "Id",
                keyValue: 13);

            migrationBuilder.DeleteData(
                table: "CompetitionsRefereesMatch",
                keyColumn: "Id",
                keyValue: 14);

            migrationBuilder.DeleteData(
                table: "CompetitionsRefereesMatch",
                keyColumn: "Id",
                keyValue: 15);

            migrationBuilder.DeleteData(
                table: "CompetitionsRefereesMatch",
                keyColumn: "Id",
                keyValue: 16);

            migrationBuilder.DeleteData(
                table: "CompetitionsRefereesMatch",
                keyColumn: "Id",
                keyValue: 17);

            migrationBuilder.DeleteData(
                table: "CompetitionsRefereesMatch",
                keyColumn: "Id",
                keyValue: 18);

            migrationBuilder.DeleteData(
                table: "CompetitionsSponsors",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "CompetitionsSponsors",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "CompetitionsSponsors",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "CompetitionsSponsors",
                keyColumn: "Id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "CompetitionsSponsors",
                keyColumn: "Id",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "CompetitionsSponsors",
                keyColumn: "Id",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "CompetitionsSponsors",
                keyColumn: "Id",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "CompetitionsSponsors",
                keyColumn: "Id",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "CompetitionsSponsors",
                keyColumn: "Id",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "CompetitionsSponsors",
                keyColumn: "Id",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "CompetitionsSponsors",
                keyColumn: "Id",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "CompetitionsSponsors",
                keyColumn: "Id",
                keyValue: 12);

            migrationBuilder.DeleteData(
                table: "CompetitionsSponsors",
                keyColumn: "Id",
                keyValue: 13);

            migrationBuilder.DeleteData(
                table: "CompetitionsSponsors",
                keyColumn: "Id",
                keyValue: 14);

            migrationBuilder.DeleteData(
                table: "CompetitionsSponsors",
                keyColumn: "Id",
                keyValue: 15);

            migrationBuilder.DeleteData(
                table: "CompetitionsSponsors",
                keyColumn: "Id",
                keyValue: 16);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeams",
                keyColumn: "Id",
                keyValue: 21);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeams",
                keyColumn: "Id",
                keyValue: 22);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeams",
                keyColumn: "Id",
                keyValue: 23);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeams",
                keyColumn: "Id",
                keyValue: 24);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeams",
                keyColumn: "Id",
                keyValue: 25);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 12);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 13);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 14);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 15);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 16);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 17);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 18);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 19);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 20);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 21);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 22);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 23);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 24);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 25);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 26);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 27);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 28);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 29);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 30);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 31);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 32);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 33);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 34);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 35);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 36);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 37);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 38);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 39);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 40);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 41);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 42);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 43);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 44);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 45);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 46);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 47);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 48);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 49);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 50);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 51);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 52);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 53);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 54);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 55);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 56);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 57);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 58);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 59);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 60);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 61);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 62);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 63);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 64);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 65);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 66);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 67);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 68);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 69);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 70);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 71);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 72);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 73);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 74);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 75);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 76);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 77);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 78);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 79);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 80);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 81);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 82);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 83);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 84);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 85);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 86);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 87);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 88);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 89);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 90);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 91);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 92);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 93);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 94);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 95);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 96);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 97);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 98);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 99);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 100);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 101);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 102);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 103);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 104);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 105);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 106);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 107);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 108);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 109);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 110);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 111);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 112);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 113);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 114);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 118);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 119);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 120);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 122);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 123);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 124);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 125);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 129);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 130);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 131);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 132);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 134);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 135);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 136);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 137);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 138);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 141);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 142);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 143);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 145);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 146);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 147);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 148);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 149);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 152);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 153);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 154);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 156);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 157);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 158);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 159);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 160);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 161);

            migrationBuilder.DeleteData(
                table: "FavoriteCompetitions",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "FavoriteCompetitions",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "FavoriteCompetitions",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "FavoriteCompetitions",
                keyColumn: "Id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Goal",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Goal",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Goal",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Goal",
                keyColumn: "Id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Goal",
                keyColumn: "Id",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Goal",
                keyColumn: "Id",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Goal",
                keyColumn: "Id",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Goal",
                keyColumn: "Id",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "Goal",
                keyColumn: "Id",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "Goal",
                keyColumn: "Id",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "Goal",
                keyColumn: "Id",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "Goal",
                keyColumn: "Id",
                keyValue: 12);

            migrationBuilder.DeleteData(
                table: "Goal",
                keyColumn: "Id",
                keyValue: 13);

            migrationBuilder.DeleteData(
                table: "Goal",
                keyColumn: "Id",
                keyValue: 14);

            migrationBuilder.DeleteData(
                table: "Goal",
                keyColumn: "Id",
                keyValue: 15);

            migrationBuilder.DeleteData(
                table: "Goal",
                keyColumn: "Id",
                keyValue: 16);

            migrationBuilder.DeleteData(
                table: "Goal",
                keyColumn: "Id",
                keyValue: 17);

            migrationBuilder.DeleteData(
                table: "Goal",
                keyColumn: "Id",
                keyValue: 18);

            migrationBuilder.DeleteData(
                table: "Goal",
                keyColumn: "Id",
                keyValue: 19);

            migrationBuilder.DeleteData(
                table: "Goal",
                keyColumn: "Id",
                keyValue: 20);

            migrationBuilder.DeleteData(
                table: "Review",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Review",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Review",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Reward",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Reward",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Reward",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Reward",
                keyColumn: "Id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Reward",
                keyColumn: "Id",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Reward",
                keyColumn: "Id",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Reward",
                keyColumn: "Id",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Reward",
                keyColumn: "Id",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "Reward",
                keyColumn: "Id",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "Reward",
                keyColumn: "Id",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "Reward",
                keyColumn: "Id",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "Reward",
                keyColumn: "Id",
                keyValue: 12);

            migrationBuilder.DeleteData(
                table: "Sponsors",
                keyColumn: "Id",
                keyValue: 17);

            migrationBuilder.DeleteData(
                table: "Sponsors",
                keyColumn: "Id",
                keyValue: 18);

            migrationBuilder.DeleteData(
                table: "Sponsors",
                keyColumn: "Id",
                keyValue: 19);

            migrationBuilder.DeleteData(
                table: "Sponsors",
                keyColumn: "Id",
                keyValue: 20);

            migrationBuilder.DeleteData(
                table: "Stadium",
                keyColumn: "Id",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Stadium",
                keyColumn: "Id",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Stadium",
                keyColumn: "Id",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Stadium",
                keyColumn: "Id",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "Stadium",
                keyColumn: "Id",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "Stadium",
                keyColumn: "Id",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "Stadium",
                keyColumn: "Id",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "Stadium",
                keyColumn: "Id",
                keyValue: 12);

            migrationBuilder.DeleteData(
                table: "Stadium",
                keyColumn: "Id",
                keyValue: 13);

            migrationBuilder.DeleteData(
                table: "Stadium",
                keyColumn: "Id",
                keyValue: 14);

            migrationBuilder.DeleteData(
                table: "Stadium",
                keyColumn: "Id",
                keyValue: 15);

            migrationBuilder.DeleteData(
                table: "Stadium",
                keyColumn: "Id",
                keyValue: 16);

            migrationBuilder.DeleteData(
                table: "Stadium",
                keyColumn: "Id",
                keyValue: 17);

            migrationBuilder.DeleteData(
                table: "Stadium",
                keyColumn: "Id",
                keyValue: 18);

            migrationBuilder.DeleteData(
                table: "Stadium",
                keyColumn: "Id",
                keyValue: 19);

            migrationBuilder.DeleteData(
                table: "Stadium",
                keyColumn: "Id",
                keyValue: 20);

            migrationBuilder.DeleteData(
                table: "User",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "City",
                keyColumn: "Id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Competition",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "CompetitionsReferees",
                keyColumn: "Id",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "CompetitionsReferees",
                keyColumn: "Id",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "CompetitionsReferees",
                keyColumn: "Id",
                keyValue: 12);

            migrationBuilder.DeleteData(
                table: "CompetitionsReferees",
                keyColumn: "Id",
                keyValue: 13);

            migrationBuilder.DeleteData(
                table: "CompetitionsReferees",
                keyColumn: "Id",
                keyValue: 18);

            migrationBuilder.DeleteData(
                table: "CompetitionsReferees",
                keyColumn: "Id",
                keyValue: 19);

            migrationBuilder.DeleteData(
                table: "CompetitionsReferees",
                keyColumn: "Id",
                keyValue: 20);

            migrationBuilder.DeleteData(
                table: "CompetitionsReferees",
                keyColumn: "Id",
                keyValue: 21);

            migrationBuilder.DeleteData(
                table: "CompetitionsReferees",
                keyColumn: "Id",
                keyValue: 22);

            migrationBuilder.DeleteData(
                table: "CompetitionsReferees",
                keyColumn: "Id",
                keyValue: 23);

            migrationBuilder.DeleteData(
                table: "CompetitionsReferees",
                keyColumn: "Id",
                keyValue: 24);

            migrationBuilder.DeleteData(
                table: "CompetitionsReferees",
                keyColumn: "Id",
                keyValue: 25);

            migrationBuilder.DeleteData(
                table: "CompetitionsReferees",
                keyColumn: "Id",
                keyValue: 26);

            migrationBuilder.DeleteData(
                table: "CompetitionsReferees",
                keyColumn: "Id",
                keyValue: 27);

            migrationBuilder.DeleteData(
                table: "CompetitionsReferees",
                keyColumn: "Id",
                keyValue: 28);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeams",
                keyColumn: "Id",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeams",
                keyColumn: "Id",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeams",
                keyColumn: "Id",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeams",
                keyColumn: "Id",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeams",
                keyColumn: "Id",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeams",
                keyColumn: "Id",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeams",
                keyColumn: "Id",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeams",
                keyColumn: "Id",
                keyValue: 12);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeams",
                keyColumn: "Id",
                keyValue: 13);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeams",
                keyColumn: "Id",
                keyValue: 14);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeams",
                keyColumn: "Id",
                keyValue: 15);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeams",
                keyColumn: "Id",
                keyValue: 16);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeams",
                keyColumn: "Id",
                keyValue: 17);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeams",
                keyColumn: "Id",
                keyValue: 18);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeams",
                keyColumn: "Id",
                keyValue: 19);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeams",
                keyColumn: "Id",
                keyValue: 20);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 115);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 116);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 117);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 121);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 126);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 127);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 128);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 133);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 139);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 140);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 144);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 150);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 151);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 155);

            migrationBuilder.DeleteData(
                table: "Match",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Match",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Match",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Match",
                keyColumn: "Id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Match",
                keyColumn: "Id",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Match",
                keyColumn: "Id",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Match",
                keyColumn: "Id",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Match",
                keyColumn: "Id",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "Match",
                keyColumn: "Id",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 12);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 13);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 14);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 18);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 19);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 20);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 22);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 23);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 24);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 25);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 29);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 30);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 31);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 32);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 34);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 35);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 36);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 37);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 38);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 41);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 42);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 43);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 45);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 46);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 47);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 48);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 49);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 52);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 53);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 54);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 56);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 57);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 58);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 59);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 60);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 61);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 62);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 63);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 64);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 65);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 66);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 67);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 68);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 69);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 70);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 71);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 72);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 73);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 74);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 75);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 76);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 77);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 78);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 79);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 80);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 81);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 82);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 83);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 84);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 85);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 86);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 87);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 88);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 89);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 90);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 91);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 92);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 93);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 94);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 95);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 96);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 97);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 98);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 99);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 100);

            migrationBuilder.DeleteData(
                table: "Referee",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Referee",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Referee",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Referee",
                keyColumn: "Id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Referee",
                keyColumn: "Id",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Referee",
                keyColumn: "Id",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Referee",
                keyColumn: "Id",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Referee",
                keyColumn: "Id",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "Referee",
                keyColumn: "Id",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "Role",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Sponsors",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Sponsors",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Sponsors",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Sponsors",
                keyColumn: "Id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Sponsors",
                keyColumn: "Id",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Sponsors",
                keyColumn: "Id",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Sponsors",
                keyColumn: "Id",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Sponsors",
                keyColumn: "Id",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "Sponsors",
                keyColumn: "Id",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "Sponsors",
                keyColumn: "Id",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "Sponsors",
                keyColumn: "Id",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "Sponsors",
                keyColumn: "Id",
                keyValue: 12);

            migrationBuilder.DeleteData(
                table: "Sponsors",
                keyColumn: "Id",
                keyValue: 13);

            migrationBuilder.DeleteData(
                table: "Sponsors",
                keyColumn: "Id",
                keyValue: 14);

            migrationBuilder.DeleteData(
                table: "Sponsors",
                keyColumn: "Id",
                keyValue: 15);

            migrationBuilder.DeleteData(
                table: "Sponsors",
                keyColumn: "Id",
                keyValue: 16);

            migrationBuilder.DeleteData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 16);

            migrationBuilder.DeleteData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 17);

            migrationBuilder.DeleteData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 18);

            migrationBuilder.DeleteData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 19);

            migrationBuilder.DeleteData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 20);

            migrationBuilder.DeleteData(
                table: "User",
                keyColumn: "Id",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "City",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeams",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeams",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeams",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeams",
                keyColumn: "Id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeams",
                keyColumn: "Id",
                keyValue: 26);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeams",
                keyColumn: "Id",
                keyValue: 27);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeams",
                keyColumn: "Id",
                keyValue: 28);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeams",
                keyColumn: "Id",
                keyValue: 29);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeams",
                keyColumn: "Id",
                keyValue: 30);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeams",
                keyColumn: "Id",
                keyValue: 31);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeams",
                keyColumn: "Id",
                keyValue: 32);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeams",
                keyColumn: "Id",
                keyValue: 33);

            migrationBuilder.DeleteData(
                table: "Fixture",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Fixture",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Fixture",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Fixture",
                keyColumn: "Id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Group",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Group",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Group",
                keyColumn: "Id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Group",
                keyColumn: "Id",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 15);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 16);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 17);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 21);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 26);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 27);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 28);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 33);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 39);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 40);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 44);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 50);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 51);

            migrationBuilder.DeleteData(
                table: "Player",
                keyColumn: "Id",
                keyValue: 55);

            migrationBuilder.DeleteData(
                table: "Referee",
                keyColumn: "Id",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "Referee",
                keyColumn: "Id",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "Referee",
                keyColumn: "Id",
                keyValue: 12);

            migrationBuilder.DeleteData(
                table: "Referee",
                keyColumn: "Id",
                keyValue: 13);

            migrationBuilder.DeleteData(
                table: "Referee",
                keyColumn: "Id",
                keyValue: 14);

            migrationBuilder.DeleteData(
                table: "Referee",
                keyColumn: "Id",
                keyValue: 15);

            migrationBuilder.DeleteData(
                table: "Referee",
                keyColumn: "Id",
                keyValue: 16);

            migrationBuilder.DeleteData(
                table: "Referee",
                keyColumn: "Id",
                keyValue: 17);

            migrationBuilder.DeleteData(
                table: "Referee",
                keyColumn: "Id",
                keyValue: 18);

            migrationBuilder.DeleteData(
                table: "Referee",
                keyColumn: "Id",
                keyValue: 19);

            migrationBuilder.DeleteData(
                table: "Referee",
                keyColumn: "Id",
                keyValue: 20);

            migrationBuilder.DeleteData(
                table: "Role",
                keyColumn: "Id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Stadium",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Stadium",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Stadium",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Stadium",
                keyColumn: "Id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 12);

            migrationBuilder.DeleteData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 13);

            migrationBuilder.DeleteData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 14);

            migrationBuilder.DeleteData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 15);

            migrationBuilder.DeleteData(
                table: "Competition",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Competition",
                keyColumn: "Id",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Group",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Selection",
                keyColumn: "Id",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "Selection",
                keyColumn: "Id",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "Selection",
                keyColumn: "Id",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "Selection",
                keyColumn: "Id",
                keyValue: 12);

            migrationBuilder.DeleteData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "User",
                keyColumn: "Id",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "City",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "City",
                keyColumn: "Id",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "Competition",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Selection",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Selection",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Selection",
                keyColumn: "Id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Selection",
                keyColumn: "Id",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Selection",
                keyColumn: "Id",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Selection",
                keyColumn: "Id",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Selection",
                keyColumn: "Id",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "User",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "User",
                keyColumn: "Id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "City",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Role",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Selection",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "User",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Role",
                keyColumn: "Id",
                keyValue: 1);
        }
    }
}
