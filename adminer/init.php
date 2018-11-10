<?php
/**
 * Adminer Extension
 */

function adminer_object() {
	class AdminerSoftware extends Adminer {
		private $creds = array();
		function __constructor() {
			$this->creds = array(
				'host'     => getenv( 'MYSQL_HOST' ),
				'database' => getenv( 'MYSQL_DATABASE' ),
				'user'     => getenv( 'MYSQL_USER' ),
				'pass'     => getenv( 'MYSQL_PASSWORD' ),
			);
		}
		function name() {
			return '<a href="http://adminer.localhost/" id="h1">Adminer</a>';
		}
		function credentials() {
			return array( $this->creds['host'], $this->creds['user'], $this->creds['password'] );
		}
		function permanentLogin( $create = false ) {
			return 'login_key';
		}
		function database() {
			return $this->creds['database'];
		}
	}
	return new AdminerSoftware;
}
include './adminer.php';
