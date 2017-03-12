
/**
 * Author:  umaha
 * Created: Nov 1, 2016
 */

SELECT 
	m.id_mhs, fm.id_pd,

	/* Informasi Mahasiswa : nama, tmpt & lahir, ibu kandung di exclude dr update */
	decode(p.kelamin_pengguna, 1, 'L', 2, 'P', NULL, 'L') as jk, /* default Laki-Laki */
	null as nisn, 
	null as nik,
	NVL((select id_feeder from agama where agama.id_agama = p.id_agama), 1) as id_agama,  /* default Islam */
	0 as id_kk,

	/* satuan pendidikan */
	'@id_sp' as id_sp,

	/* Info tempat tinggal */
	SUBSTR(COALESCE(alamat_asal_mhs, alamat_mhs), 1, 80) as jln,
	null as rt, 
	null as rw, 
	null as nm_dsn, 
	NVL(SUBSTR(COALESCE(alamat_asal_mhs, alamat_mhs), 1, 60), 'Belum Terekam') as ds_kel,
	'000000' as id_wil,
	null as kode_pos,
	null as id_jns_tinggal,
	null as id_alat_transport,
	null as telepon_rumah,
	SUBSTR(mobile_mhs, 1, 20) as telepon_seluler,
	COALESCE(p.email_alternate, p.email_pengguna) as email,

	/* Other Info */
	0 as a_terima_kps,
	null as no_kps,
	'A' as stat_pd,

	/* Informasi Ayah */
	nm_ayah_mhs as nm_ayah,
	null as tgl_lahir_ayah,
	null as id_jenjang_pendidikan_ayah,
	null as id_pekerjaan_ayah,
	null as id_penghasilan_ayah,
	NVL(null, 0) as id_kebutuhan_khusus_ayah,

	/* Informasi Ibu */
	null as tgl_lahir_ibu,
	null as id_jenjang_pendidikan_ibu,
	null as id_pekerjaan_ibu,
	null as id_penghasilan_ibu,
	NVL(null, 0) as id_kebutuhan_khusus_ibu,

	/* Informasi Wali */
	null as nm_wali,
	null as tgl_lahir_wali,
	null as id_jenjang_pendidikan_wali,
	null as id_pekerjaan_wali,
	null as id_penghasilan_wali,

	'ID' as kewarganegaraan
FROM mahasiswa m
JOIN pengguna p ON p.id_pengguna = m.id_pengguna
JOIN program_studi ps ON ps.id_program_studi = m.id_program_studi
JOIN perguruan_tinggi pt ON pt.id_perguruan_tinggi = p.id_perguruan_tinggi
JOIN feeder_mahasiswa fm ON fm.id_mhs = m.id_mhs
WHERE 
	pt.npsn = '@npsn' AND
	ps.kode_program_studi = '@kode_prodi' AND
	m.thn_angkatan_mhs = '@angkatan' AND
	(m.id_mhs IN (SELECT id_mhs FROM feeder_mahasiswa_pt WHERE last_sync < last_update) OR m.id_mhs IN (SELECT id_mhs FROM feeder_mahasiswa WHERE last_sync < last_update))
ORDER BY 1 ASC