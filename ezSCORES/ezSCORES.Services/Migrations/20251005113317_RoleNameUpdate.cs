using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ezSCORES.Services.Migrations
{
    /// <inheritdoc />
    public partial class RoleNameUpdate : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Role",
                keyColumn: "Id",
                keyValue: 4,
                column: "Name",
                value: "Spectator");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Role",
                keyColumn: "Id",
                keyValue: 4,
                column: "Name",
                value: "Manager");
        }
    }
}
