{extends file='home_layout.tpl'}
{block name='head'}
	<style>tr.jumlahdata > td { font-size: 140% }</style>
{/block}
{block name='body-content'}
	<div class="row">
		<div class="col-md-12">
			<div class="page-header">
				<h2>Sinkronisasi Nilai Perkuliahan</h2>
			</div>

			<table class="table table-bordered table-condensed" style="width: auto">
				<thead>
					<tr>
						<th>Nilai Perkuliahan</th>
						<th>Feeder</th>
						<th>Sistem Langitan</th>
						<th>Link</th>
						<th></th>
						<th>Update</th>
						<th>Insert</th>
					</tr>
				</thead>
				<tbody>
					<tr class="jumlahdata">
						<td>Jumlah Data</td>
						<td class="text-center">{$jumlah.feeder}</td>
						<td class="text-center">{$jumlah.langitan}</td>
						<td class="text-center">{$jumlah.linked}</td>
						<td></td>
						<td class="text-center text-warning">&#8710;{$jumlah.update}</td>
						<td class="text-center text-success">+{$jumlah['insert']}</td>
					</tr>
				</tbody>
			</table>

			<p class="lead text-success">Pastikan melakukan sinkronisasi pada periode semester yang terbuka.
				Sinkronisasi pada semester yang tidak terbuka mengakibatkan kegagalan sinkronisasi pada aplikasi Feeder.</p>

			<form class="form-horizontal" action="{$url_sync}" method="post">
				<fieldset>

					<!-- Form Name -->
					<legend>Filter Data</legend>

					<!-- Select Basic -->
					<div class="form-group">
						<label class="col-md-2 control-label" for="selectbasic">Program Studi</label>
						<div class="col-md-4">
							<select name="kode_prodi" class="form-control" required>
								<option value=""></option>
								{foreach $program_studi_set as $ps}
									<option value="{$ps.KODE_PROGRAM_STUDI}">{$ps.NM_JENJANG} {$ps.NM_PROGRAM_STUDI}</option>
								{/foreach}
							</select>
						</div>
					</div>

					<!-- Select Basic -->
					<div class="form-group">
						<label class="col-md-2 control-label" for="selectbasic">Semester</label>
						<div class="col-md-4">
							<select name="semester" class="form-control" required>
								<option value=""></option>
								{for $tahun=date('Y') to date('Y')-3 step -1}
									<option value="{$tahun}2">{$tahun}/{$tahun + 1} Genap</option>
									<option value="{$tahun}1">{$tahun}/{$tahun + 1} Ganjil</option>
								{/for}
							</select>
						</div>
					</div>
							
					<!-- Select Basic -->
					<div class="form-group">
						<label class="col-md-2 control-label" for="selectmultiple">Kelas</label>
						<div class="col-md-6">
							<select name="id_kelas_mk" class="form-control" required><option value="0">-</option></select>
						</div>
					</div>

					<!-- Button -->
					<div class="form-group">
						<label class="col-md-4 control-label" for="singlebutton"></label>
						<div class="col-md-4">
							<input type="submit" class="btn btn-primary" value="Proses Sinkronisasi" />
						</div>
					</div>
					
				</fieldset>
			</form>


			<form action="{$url_sync}" method="post">
				
			</form>
		</div>
	</div>
{/block}
{block name='footer-script'}
	<script type="text/javascript">
		$(function(){
			
			$('input[type=submit]').prop('disabled', true);
			
			var refreshTable = function(kodeProdi, semester, id_kelas_mk) {
				var url = '{site_url('sync/nilai_data')}/'+kodeProdi+'/'+semester+'/'+id_kelas_mk;
				
				if (kodeProdi && semester && id_kelas_mk)
				{
					$.ajax({
						dataType: "json",
						url: url,
						beforeSend: function (xhr) {
							$('input[type=submit]').prop('disabled', true);
							$('body').css('cursor', 'progress');
						},
						success: function (data, textStatus, jqXHR) {
							$('tr.jumlahdata td:eq(1)').text(data.feeder);
							$('tr.jumlahdata td:eq(2)').text(data.langitan);
							$('tr.jumlahdata td:eq(3)').text(data.linked);
							$('tr.jumlahdata td:eq(5)').text('∆' + data.update);
							$('tr.jumlahdata td:eq(6)').text('+' + data.insert);
							$("input[type=submit]").prop('disabled', false);
							$('body').css('cursor', 'default');
						}
					});
				}
				
			};
			
			var ambilKelas = function(kodeProdi, semester) {
				if (kodeProdi && semester) {
					$.ajax({
						dataType: "json",
						url: '{site_url('sync/ambil_kelas')}/'+kodeProdi+'/'+semester,
						beforeSend: function (xhr) {
							$('select[name=id_kelas_mk]').html('');
							$('select[name=id_kelas_mk]').append('<option value="">[Pilih Kelas]</option>');
						},
						success: function (data, textStatus, jqXHR) {
							// Insert ke combo
							$.each(data, function(key, val) {
                                if (val.PERLU_SYNC == 0)
                                    $('select[name=id_kelas_mk]').append('<option value="'+val.ID_KELAS_MK+'">'+(key + 1)+'. '+val.NM_KELAS+' Peserta: '+val.PESERTA+' Ada Nilai: '+val.ADA_NILAI+'</option>');
                                else
                                    $('select[name=id_kelas_mk]').append('<option value="'+val.ID_KELAS_MK+'" style="background-color: #5cb85c; color: #fff">'+(key + 1)+'. '+val.NM_KELAS+' Peserta: '+val.PESERTA+' Ada Nilai: '+val.ADA_NILAI+'</option>');
							});
						}
					});
				}
			};
			
			$('select[name=kode_prodi]').on('change', function(){
				ambilKelas($('select[name=kode_prodi]').val(), $('select[name=semester]').val());
			});
			
			$('select[name=semester]').on('change', function(){
				ambilKelas($('select[name=kode_prodi]').val(), $('select[name=semester]').val());
			});
			
			$('select[name=id_kelas_mk]').on('change', function() {
				refreshTable($('select[name=kode_prodi]').val(), $('select[name=semester]').val(), $('select[name=id_kelas_mk]').val());
			});
		});
	</script>
{/block}