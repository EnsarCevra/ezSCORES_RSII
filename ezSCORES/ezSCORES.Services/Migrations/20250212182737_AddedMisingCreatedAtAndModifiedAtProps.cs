using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ezSCORES.Services.Migrations
{
    /// <inheritdoc />
    public partial class AddedMisingCreatedAtAndModifiedAtProps : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<DateTime>(
                name: "ModifiedAt",
                table: "Review",
                type: "datetime2",
                nullable: true,
                oldClrType: typeof(DateTime),
                oldType: "datetime2");

            migrationBuilder.AddColumn<DateTime>(
                name: "CreatedAt",
                table: "CompetitionsTeamsPlayers",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.AddColumn<bool>(
                name: "IsActive",
                table: "CompetitionsTeamsPlayers",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<DateTime>(
                name: "ModifiedAt",
                table: "CompetitionsTeamsPlayers",
                type: "datetime2",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "CreatedAt",
                table: "CompetitionsTeamsPlayers");

            migrationBuilder.DropColumn(
                name: "IsActive",
                table: "CompetitionsTeamsPlayers");

            migrationBuilder.DropColumn(
                name: "ModifiedAt",
                table: "CompetitionsTeamsPlayers");

            migrationBuilder.AlterColumn<DateTime>(
                name: "ModifiedAt",
                table: "Review",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified),
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldNullable: true);
        }
    }
}
