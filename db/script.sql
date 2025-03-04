-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pengajuan_surat_if
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `pengajuan_surat_if` ;

-- -----------------------------------------------------
-- Schema pengajuan_surat_if
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pengajuan_surat_if` DEFAULT CHARACTER SET utf8 ;
USE `pengajuan_surat_if` ;

-- -----------------------------------------------------
-- Table `pengajuan_surat_if`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pengajuan_surat_if`.`users` ;

CREATE TABLE IF NOT EXISTS `pengajuan_surat_if`.`users` (
  `username` VARCHAR(9) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NULL,
  `password` VARCHAR(100) NOT NULL,
  `role` VARCHAR(10) NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  `status` VARCHAR(11) NULL,
  PRIMARY KEY (`username`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pengajuan_surat_if`.`surat`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pengajuan_surat_if`.`surat` ;

CREATE TABLE IF NOT EXISTS `pengajuan_surat_if`.`surat` (
  `surat_id` VARCHAR(20) NOT NULL,
  `jenis_surat` VARCHAR(50) NULL,
  `status_pengajuan` VARCHAR(20) NULL,
  `file_surat` VARCHAR(100) NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  `id_mhs` VARCHAR(9) NULL,
  PRIMARY KEY (`surat_id`),
  INDEX `id_mhs_idx` (`id_mhs` ASC) VISIBLE,
  CONSTRAINT `id_mhs`
    FOREIGN KEY (`id_mhs`)
    REFERENCES `pengajuan_surat_if`.`users` (`username`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pengajuan_surat_if`.`surat_mhs_aktif`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pengajuan_surat_if`.`surat_mhs_aktif` ;

CREATE TABLE IF NOT EXISTS `pengajuan_surat_if`.`surat_mhs_aktif` (
  `id_surat` VARCHAR(20) NOT NULL,
  `surat_id` VARCHAR(9) NULL,
  `semester` INT NULL,
  `keperluan` VARCHAR(100) NULL,
  PRIMARY KEY (`id_surat`),
  INDEX `surat_id_idx` (`surat_id` ASC) VISIBLE,
  CONSTRAINT `mhs_surat_id`
    FOREIGN KEY (`surat_id`)
    REFERENCES `pengajuan_surat_if`.`surat` (`surat_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pengajuan_surat_if`.`surat_pengantar`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pengajuan_surat_if`.`surat_pengantar` ;

CREATE TABLE IF NOT EXISTS `pengajuan_surat_if`.`surat_pengantar` (
  `id_surat` VARCHAR(20) NOT NULL,
  `surat_id` VARCHAR(9) NULL,
  `penerima` VARCHAR(100) NULL,
  `nama_mk` VARCHAR(45) NULL,
  `kode_mk` VARCHAR(10) NULL,
  `periode` VARCHAR(10) NULL,
  `tujuan` VARCHAR(100) NULL,
  `topik` VARCHAR(100) NULL,
  `data_mhs` VARCHAR(150) NULL,
  `created_at` TIMESTAMP NULL,
  PRIMARY KEY (`id_surat`),
  INDEX `surat_id_idx` (`surat_id` ASC) VISIBLE,
  CONSTRAINT `pengantar_surat_id`
    FOREIGN KEY (`surat_id`)
    REFERENCES `pengajuan_surat_if`.`surat` (`surat_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pengajuan_surat_if`.`surat_ket_lulus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pengajuan_surat_if`.`surat_ket_lulus` ;

CREATE TABLE IF NOT EXISTS `pengajuan_surat_if`.`surat_ket_lulus` (
  `id_surat` VARCHAR(20) NOT NULL,
  `surat_id` VARCHAR(9) NULL,
  `tgl_lulus` DATE NULL,
  `created_at` TIMESTAMP NULL,
  PRIMARY KEY (`id_surat`),
  INDEX `surat_id_idx` (`surat_id` ASC) VISIBLE,
  CONSTRAINT `lulus_surat_id`
    FOREIGN KEY (`surat_id`)
    REFERENCES `pengajuan_surat_if`.`surat` (`surat_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pengajuan_surat_if`.`surat_lhs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pengajuan_surat_if`.`surat_lhs` ;

CREATE TABLE IF NOT EXISTS `pengajuan_surat_if`.`surat_lhs` (
  `id_surat` VARCHAR(20) NOT NULL,
  `surat_id` VARCHAR(9) NULL,
  `keperluan` VARCHAR(100) NULL,
  `created_at` TIMESTAMP NULL,
  PRIMARY KEY (`id_surat`),
  INDEX `surat_id_idx` (`surat_id` ASC) VISIBLE,
  CONSTRAINT `lhs_surat_id`
    FOREIGN KEY (`surat_id`)
    REFERENCES `pengajuan_surat_if`.`surat` (`surat_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pengajuan_surat_if`.`notifikasi`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pengajuan_surat_if`.`notifikasi` ;

CREATE TABLE IF NOT EXISTS `pengajuan_surat_if`.`notifikasi` (
  `id_notifikasi` VARCHAR(20) NOT NULL,
  `id_penerima` VARCHAR(9) NULL,
  `id_pengirim` VARCHAR(9) NULL,
  `pesan` VARCHAR(30) NULL,
  `status` ENUM('terkirim', 'dibaca') NULL,
  `created_at` TIMESTAMP NULL,
  `surat_id` VARCHAR(20) NULL,
  PRIMARY KEY (`id_notifikasi`),
  INDEX `id_penerima_idx` (`id_penerima` ASC) VISIBLE,
  INDEX `id_pengirim_idx` (`id_pengirim` ASC) VISIBLE,
  INDEX `surat_id_idx` (`surat_id` ASC) VISIBLE,
  CONSTRAINT `id_penerima`
    FOREIGN KEY (`id_penerima`)
    REFERENCES `pengajuan_surat_if`.`users` (`username`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `id_pengirim`
    FOREIGN KEY (`id_pengirim`)
    REFERENCES `pengajuan_surat_if`.`users` (`username`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `surat_notif`
    FOREIGN KEY (`surat_id`)
    REFERENCES `pengajuan_surat_if`.`surat` (`surat_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
