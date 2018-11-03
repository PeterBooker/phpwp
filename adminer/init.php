<?php
/**
 * Adminer Extension
 */

function adminer_object() {
	class AdminerSoftware extends Adminer {
		private $creds = array();
		function init() {
			$this->creds = array(
				'host'     => getenv( 'MYSQL_HOST' ),
				'database' => getenv( 'MYSQL_DATABASE' ),
				'user'     => getenv( 'MYSQL_USER' ),
				'pass'     => getenv( 'MYSQL_PASSWORD' ),
			);
		}

		function name() {
			return $this->creds['database'];
		}
		function credentials() {
			return array( $this->creds['host'], $this->creds['user'], $this->creds['pass'] );
		}
		function database() {
			return $this->creds['database'];
		}
  }
  return new AdminerSoftware;
}
include './adminer.php';