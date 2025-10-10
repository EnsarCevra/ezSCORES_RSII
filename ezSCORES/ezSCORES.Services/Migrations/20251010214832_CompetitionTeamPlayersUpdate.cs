using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace ezSCORES.Services.Migrations
{
    /// <inheritdoc />
    public partial class CompetitionTeamPlayersUpdate : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
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

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 115,
                column: "CompetitionsTeamsId",
                value: 21);

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 116,
                column: "CompetitionsTeamsId",
                value: 21);

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 117,
                column: "CompetitionsTeamsId",
                value: 21);

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 118,
                column: "CompetitionsTeamsId",
                value: 21);

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 119,
                column: "CompetitionsTeamsId",
                value: 21);

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 120,
                column: "CompetitionsTeamsId",
                value: 21);

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 121,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 21, 14 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 122,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 26, 15 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 123,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 26, 16 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 124,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 26, 17 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 125,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 26, 18 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 126,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 26, 19 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 127,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 26, 20 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 128,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 27, 21 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 129,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 27, 22 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 130,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 27, 23 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 131,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 27, 24 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 132,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 27, 25 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 133,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 28, 26 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 134,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 28, 27 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 135,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 28, 28 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 136,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 28, 29 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 137,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 28, 30 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 138,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 28, 31 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 139,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 28, 32 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 140,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 29, 33 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 141,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 29, 34 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 142,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 29, 35 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 143,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 29, 36 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 144,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 29, 37 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 145,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 29, 38 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 146,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 30, 39 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 147,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 30, 40 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 148,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 30, 41 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 149,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 30, 42 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 150,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 30, 43 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 151,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 31, 44 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 152,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 31, 45 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 153,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 31, 46 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 154,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 31, 47 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 155,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 31, 48 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 156,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 31, 49 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 157,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 32, 50 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 158,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 32, 51 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 159,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 32, 52 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 160,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 32, 53 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 161,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 32, 54 });

            migrationBuilder.InsertData(
                table: "CompetitionsTeamsPlayers",
                columns: new[] { "Id", "CompetitionsTeamsId", "CreatedAt", "GoalsTotal", "IsActive", "IsDeleted", "IsVerified", "ModifiedAt", "PlayerId", "RemovedAt" },
                values: new object[,]
                {
                    { 162, 33, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 55, null },
                    { 163, 33, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 56, null },
                    { 164, 33, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 57, null },
                    { 165, 33, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 58, null },
                    { 166, 33, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 59, null },
                    { 167, 33, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 60, null },
                    { 168, 33, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), 0, true, false, true, null, 61, null }
                });

            migrationBuilder.UpdateData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 1,
                column: "SelectionId",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 3,
                column: "SelectionId",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 4,
                column: "SelectionId",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 5,
                column: "SelectionId",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 6,
                column: "SelectionId",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 7,
                column: "SelectionId",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 8,
                column: "SelectionId",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 9,
                column: "SelectionId",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 10,
                column: "SelectionId",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 11,
                column: "SelectionId",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 12,
                column: "SelectionId",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 13,
                column: "SelectionId",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 15,
                column: "SelectionId",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 16,
                column: "SelectionId",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 17,
                column: "SelectionId",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 18,
                column: "SelectionId",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 19,
                column: "SelectionId",
                value: 2);

            migrationBuilder.UpdateData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 20,
                column: "SelectionId",
                value: 2);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 162);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 163);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 164);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 165);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 166);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 167);

            migrationBuilder.DeleteData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 168);

            migrationBuilder.InsertData(
                table: "Application",
                columns: new[] { "Id", "CompetitionId", "CreatedAt", "IsAccepted", "IsActive", "IsDeleted", "IsPaId", "Message", "ModifiedAt", "PaIdAmount", "RemovedAt", "TeamId" },
                values: new object[,]
                {
                    { 22, 3, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), null, true, false, false, "Prijava tima", null, null, null, 17 },
                    { 23, 3, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), null, true, false, false, "Prijava tima", null, null, null, 18 },
                    { 24, 3, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), null, true, false, false, "Prijava tima", null, null, null, 19 },
                    { 25, 3, new DateTime(2025, 10, 4, 14, 30, 0, 0, DateTimeKind.Unspecified), null, true, false, false, "Prijava tima", null, null, null, 20 }
                });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 115,
                column: "CompetitionsTeamsId",
                value: 26);

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 116,
                column: "CompetitionsTeamsId",
                value: 26);

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 117,
                column: "CompetitionsTeamsId",
                value: 26);

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 118,
                column: "CompetitionsTeamsId",
                value: 26);

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 119,
                column: "CompetitionsTeamsId",
                value: 26);

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 120,
                column: "CompetitionsTeamsId",
                value: 26);

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 121,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 27, 21 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 122,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 27, 22 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 123,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 27, 23 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 124,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 27, 24 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 125,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 27, 25 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 126,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 28, 26 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 127,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 28, 27 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 128,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 28, 28 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 129,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 28, 29 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 130,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 28, 30 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 131,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 28, 31 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 132,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 28, 32 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 133,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 29, 33 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 134,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 29, 34 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 135,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 29, 35 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 136,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 29, 36 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 137,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 29, 37 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 138,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 29, 38 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 139,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 30, 39 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 140,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 30, 40 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 141,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 30, 41 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 142,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 30, 42 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 143,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 30, 43 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 144,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 31, 44 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 145,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 31, 45 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 146,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 31, 46 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 147,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 31, 47 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 148,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 31, 48 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 149,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 31, 49 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 150,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 32, 50 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 151,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 32, 51 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 152,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 32, 52 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 153,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 32, 53 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 154,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 32, 54 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 155,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 33, 55 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 156,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 33, 56 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 157,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 33, 57 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 158,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 33, 58 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 159,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 33, 59 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 160,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 33, 60 });

            migrationBuilder.UpdateData(
                table: "CompetitionsTeamsPlayers",
                keyColumn: "Id",
                keyValue: 161,
                columns: new[] { "CompetitionsTeamsId", "PlayerId" },
                values: new object[] { 33, 61 });

            migrationBuilder.UpdateData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 1,
                column: "SelectionId",
                value: 1);

            migrationBuilder.UpdateData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 3,
                column: "SelectionId",
                value: 3);

            migrationBuilder.UpdateData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 4,
                column: "SelectionId",
                value: 4);

            migrationBuilder.UpdateData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 5,
                column: "SelectionId",
                value: 5);

            migrationBuilder.UpdateData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 6,
                column: "SelectionId",
                value: 6);

            migrationBuilder.UpdateData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 7,
                column: "SelectionId",
                value: 7);

            migrationBuilder.UpdateData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 8,
                column: "SelectionId",
                value: 8);

            migrationBuilder.UpdateData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 9,
                column: "SelectionId",
                value: 9);

            migrationBuilder.UpdateData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 10,
                column: "SelectionId",
                value: 10);

            migrationBuilder.UpdateData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 11,
                column: "SelectionId",
                value: 11);

            migrationBuilder.UpdateData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 12,
                column: "SelectionId",
                value: 12);

            migrationBuilder.UpdateData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 13,
                column: "SelectionId",
                value: 1);

            migrationBuilder.UpdateData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 15,
                column: "SelectionId",
                value: 3);

            migrationBuilder.UpdateData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 16,
                column: "SelectionId",
                value: 4);

            migrationBuilder.UpdateData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 17,
                column: "SelectionId",
                value: 5);

            migrationBuilder.UpdateData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 18,
                column: "SelectionId",
                value: 6);

            migrationBuilder.UpdateData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 19,
                column: "SelectionId",
                value: 7);

            migrationBuilder.UpdateData(
                table: "Team",
                keyColumn: "Id",
                keyValue: 20,
                column: "SelectionId",
                value: 8);
        }
    }
}
