using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ezSCORES.Services.Migrations
{
    /// <inheritdoc />
    public partial class UpdateDataSeed : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Application",
                keyColumn: "Id",
                keyValue: 22,
                column: "IsAccepted",
                value: null);

            migrationBuilder.UpdateData(
                table: "Application",
                keyColumn: "Id",
                keyValue: 23,
                column: "IsAccepted",
                value: null);

            migrationBuilder.UpdateData(
                table: "Application",
                keyColumn: "Id",
                keyValue: 24,
                column: "IsAccepted",
                value: null);

            migrationBuilder.UpdateData(
                table: "Application",
                keyColumn: "Id",
                keyValue: 25,
                column: "IsAccepted",
                value: null);

            migrationBuilder.UpdateData(
                table: "Fixture",
                keyColumn: "Id",
                keyValue: 1,
                column: "SequenceNumber",
                value: 0);

            migrationBuilder.UpdateData(
                table: "Goal",
                keyColumn: "Id",
                keyValue: 16,
                columns: new[] { "CompetitionTeamPlayerId", "IsHomeGoal" },
                values: new object[] { 115, true });

            migrationBuilder.UpdateData(
                table: "Goal",
                keyColumn: "Id",
                keyValue: 18,
                columns: new[] { "CompetitionTeamPlayerId", "IsHomeGoal" },
                values: new object[] { 139, true });

            migrationBuilder.UpdateData(
                table: "Goal",
                keyColumn: "Id",
                keyValue: 20,
                columns: new[] { "CompetitionTeamPlayerId", "IsHomeGoal" },
                values: new object[] { 115, true });

            migrationBuilder.UpdateData(
                table: "User",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "PasswordHash", "PasswordSalt" },
                values: new object[] { "ODpOqZ0oalk6+z/9ed/n+FAFGeE=", "WCS1p9TJ0W0jWUR1KP0JaA==" });

            migrationBuilder.UpdateData(
                table: "User",
                keyColumn: "Id",
                keyValue: 2,
                columns: new[] { "PasswordHash", "PasswordSalt" },
                values: new object[] { "ODpOqZ0oalk6+z/9ed/n+FAFGeE=", "WCS1p9TJ0W0jWUR1KP0JaA==" });

            migrationBuilder.UpdateData(
                table: "User",
                keyColumn: "Id",
                keyValue: 3,
                columns: new[] { "PasswordHash", "PasswordSalt" },
                values: new object[] { "ODpOqZ0oalk6+z/9ed/n+FAFGeE=", "WCS1p9TJ0W0jWUR1KP0JaA==" });

            migrationBuilder.UpdateData(
                table: "User",
                keyColumn: "Id",
                keyValue: 4,
                columns: new[] { "PasswordHash", "PasswordSalt" },
                values: new object[] { "ODpOqZ0oalk6+z/9ed/n+FAFGeE=", "WCS1p9TJ0W0jWUR1KP0JaA==" });

            migrationBuilder.UpdateData(
                table: "User",
                keyColumn: "Id",
                keyValue: 5,
                columns: new[] { "PasswordHash", "PasswordSalt" },
                values: new object[] { "ODpOqZ0oalk6+z/9ed/n+FAFGeE=", "WCS1p9TJ0W0jWUR1KP0JaA==" });

            migrationBuilder.UpdateData(
                table: "User",
                keyColumn: "Id",
                keyValue: 6,
                columns: new[] { "PasswordHash", "PasswordSalt" },
                values: new object[] { "ODpOqZ0oalk6+z/9ed/n+FAFGeE=", "WCS1p9TJ0W0jWUR1KP0JaA==" });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Application",
                keyColumn: "Id",
                keyValue: 22,
                column: "IsAccepted",
                value: false);

            migrationBuilder.UpdateData(
                table: "Application",
                keyColumn: "Id",
                keyValue: 23,
                column: "IsAccepted",
                value: false);

            migrationBuilder.UpdateData(
                table: "Application",
                keyColumn: "Id",
                keyValue: 24,
                column: "IsAccepted",
                value: false);

            migrationBuilder.UpdateData(
                table: "Application",
                keyColumn: "Id",
                keyValue: 25,
                column: "IsAccepted",
                value: false);

            migrationBuilder.UpdateData(
                table: "Fixture",
                keyColumn: "Id",
                keyValue: 1,
                column: "SequenceNumber",
                value: 1);

            migrationBuilder.UpdateData(
                table: "Goal",
                keyColumn: "Id",
                keyValue: 16,
                columns: new[] { "CompetitionTeamPlayerId", "IsHomeGoal" },
                values: new object[] { 126, false });

            migrationBuilder.UpdateData(
                table: "Goal",
                keyColumn: "Id",
                keyValue: 18,
                columns: new[] { "CompetitionTeamPlayerId", "IsHomeGoal" },
                values: new object[] { 150, false });

            migrationBuilder.UpdateData(
                table: "Goal",
                keyColumn: "Id",
                keyValue: 20,
                columns: new[] { "CompetitionTeamPlayerId", "IsHomeGoal" },
                values: new object[] { 139, false });

            migrationBuilder.UpdateData(
                table: "User",
                keyColumn: "Id",
                keyValue: 1,
                columns: new[] { "PasswordHash", "PasswordSalt" },
                values: new object[] { "M7zEJ+DYWDwhK9xe5h3QpSFXK9w=", "q83k3u3B9nZrV2l4Qwh0+Q==" });

            migrationBuilder.UpdateData(
                table: "User",
                keyColumn: "Id",
                keyValue: 2,
                columns: new[] { "PasswordHash", "PasswordSalt" },
                values: new object[] { "M7zEJ+DYWDwhK9xe5h3QpSFXK9w=", "q83k3u3B9nZrV2l4Qwh0+Q==" });

            migrationBuilder.UpdateData(
                table: "User",
                keyColumn: "Id",
                keyValue: 3,
                columns: new[] { "PasswordHash", "PasswordSalt" },
                values: new object[] { "M7zEJ+DYWDwhK9xe5h3QpSFXK9w=", "q83k3u3B9nZrV2l4Qwh0+Q==" });

            migrationBuilder.UpdateData(
                table: "User",
                keyColumn: "Id",
                keyValue: 4,
                columns: new[] { "PasswordHash", "PasswordSalt" },
                values: new object[] { "M7zEJ+DYWDwhK9xe5h3QpSFXK9w=", "q83k3u3B9nZrV2l4Qwh0+Q==" });

            migrationBuilder.UpdateData(
                table: "User",
                keyColumn: "Id",
                keyValue: 5,
                columns: new[] { "PasswordHash", "PasswordSalt" },
                values: new object[] { "M7zEJ+DYWDwhK9xe5h3QpSFXK9w=", "q83k3u3B9nZrV2l4Qwh0+Q==" });

            migrationBuilder.UpdateData(
                table: "User",
                keyColumn: "Id",
                keyValue: 6,
                columns: new[] { "PasswordHash", "PasswordSalt" },
                values: new object[] { "M7zEJ+DYWDwhK9xe5h3QpSFXK9w=", "q83k3u3B9nZrV2l4Qwh0+Q==" });
        }
    }
}
