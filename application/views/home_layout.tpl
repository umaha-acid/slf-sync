<!DOCTYPE html>
<html lang="id">
	<head>
		<title>{block name='title'}{/block}SLF Sync</title>
		<meta charset="UTF-8">
		<meta name="description" content="LF Sync" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta name="msapplication-config" content="none"/>
		
		<!-- Bootstrap -->
		<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
		
		<style type="text/css">
			body { padding-top: 40px; }
		</style>
		
		{if $ci->session->userdata('is_sandbox')}
		<style type="text/css">
			.navbar-inverse {
				background-color: #b94a48;
				border-color: #E7E7E7;
			}
			
			.navbar-inverse .navbar-brand {
				color: #ddd;
			}
			
			.navbar-inverse .navbar-nav > li > a {
				color: #ddd;
			}
		</style>	
		{/if}

		<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
		<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
		<!--[if lt IE 9]>
		  <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
		  <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
		<![endif]-->
		{block name='head'}{/block}
	</head>
	
	<body>
		<div class="navbar navbar-default navbar-fixed-top navbar-inverse">
			<div class="container">
				<div class="navbar-header">
					<a href="{site_url('home')}" class="navbar-brand">SLF Sync</a>
					<button class="navbar-toggle" type="button" data-toggle="collapse" data-target="#navbar-main">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					</button>
				</div>
					
				<div class="navbar-collapse collapse" id="navbar-main">
					<ul class="nav navbar-nav">
						<li>
							<a href="{site_url('home')}">Status</a>
						</li>
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown">WSDL <i class="caret"></i></a>
							<ul class="dropdown-menu">
								<li><a href="{site_url('webservice/list_table')}">Daftar Tabel</a></li>
							</ul>
						</li>
						<li>
							<a href="#" class="dropdown-toggle" data-toggle="dropdown">Link/Import Data <i class="caret"></i></a>
							<ul class="dropdown-menu">
								<li><a href="{site_url('sync_link/program_studi')}">Program Studi</a></li>
								<li><a href="{site_url('sync_link/dosen')}">Dosen</a></li>
								<li><a href="{site_url('sync_link/mahasiswa')}">Mahasiswa</a></li>
								<li><a href="{site_url('sync_link/mahasiswa_pt')}">Mahasiswa PT</a></li>
							</ul>
						</li>
						<li>
							<a href="#" class="dropdown-toggle" data-toggle="dropdown">Synchronize Data <i class="caret"></i></a>
							<ul class="dropdown-menu">
								<li><a href="{site_url('sync/mahasiswa')}">Sync Mahasiswa</a></li>
								<li><a href="{site_url('sync/lulusan_do')}">Sync Lulusan / DO</a></li>
								<li role="separator" class="divider"></li>
								<li><a href="{site_url('sync_del/mk_kurikulum')}"><span class="text-danger">Hapus MK Kurikulum</span></a></li>
								<li role="separator" class="divider"></li>
								<li><a href="{site_url('sync_del/kuliah_mahasiswa')}"><span class="text-danger">Hapus Aktivitas Perkuliahan</span></a></li>
								<li><a href="{site_url('sync_del/kuliah_mahasiswa_restore')}"><i><span class="text-success">Restore Hapus Aktivitas Perkuliahan</span></i></a></li>
							</ul>
						</li>
						<li>
							<a href="#" class="dropdown-toggle" data-toggle="dropdown">Perkuliahan <i class="caret"></i></a>
							<ul class="dropdown-menu">
								
								<li><a href="{site_url('sync/mata_kuliah')}">Sync Mata Kuliah</a></li>
								
								<li role="separator" class="divider"></li>
								
								<li><a href="{site_url('sync/kurikulum')}">Sync Kurikulum</a></li>
                                {*<li><a href="{site_url('sync/mata_kuliah_kurikulum')}">Sync Mata Kuliah Kurikulum</a></li>*}
                                <li class="disabled"><a>Sync Mata Kuliah Kurikulum</a></li>
								
								<li role="separator" class="divider"></li>
								<li><a href="{site_url('sync/kelas_kuliah')}">Sync Kelas Perkuliahan</a></li>
								<li><a href="{site_url('sync/nilai')}">Sync Nilai Perkuliahan</a></li>
								<li><a href="{site_url('sync/nilai_per_prodi')}">Sync Nilai Perkuliahan (Per Prodi)</a></li>
								<li><a href="{site_url('sync/ajar_dosen')}">Sync Dosen Pengajar Kelas</a></li>
								
								<li role="separator" class="divider"></li>
								<li><a href="{site_url('sync/kuliah_mahasiswa')}">Sync Aktivitas Mahasiswa</a></li>
								<li><a href="{site_url('sync_link/kuliah_mahasiswa')}"><span class="text-info">Link Aktivitas Mahasiswa</span></a></li>
								
								<li role="separator" class="divider"></li>
								<li><a href="{site_url('sync/nilai_transfer')}">Sync Nilai Transfer</a></li>
								<li><a href="{site_url('sync/nilai_transfer_umaha')}">Sync Nilai Transfer UMAHA (&lt;2014)</a></li>
							</ul>
						</li>
						<li>
							<a href="#" class="dropdown-toggle" data-toggle="dropdown">Hapus Data Manual<i class="caret"></i></a>
							<ul class="dropdown-menu">
								<li><a href="{site_url('delete-data/kuliah-mahasiswa')}">Aktivitas Mahasiswa</a></li>
							</ul>
						</li>
					</ul>
					<ul class="nav navbar-nav navbar-right">
						<li>
							<a href="{site_url('auth/logout')}">Logout</a>
						</li>
					</ul>
				</div>

			</div>
		</div>
		
		<div class="container">
			{block name='body-content'}{/block}
		</div>
		
		{if isset($debug)}<pre>{$debug}</pre>{/if}

		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script
			  src="https://code.jquery.com/jquery-1.12.4.min.js"
			  integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ="
			  crossorigin="anonymous"></script>
		<!-- Include all compiled plugins (below), or include individual files as needed -->
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
		{block name='footer-script'}{/block}
	</body>
</html>