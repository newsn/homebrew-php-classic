require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56MysqlndMs < AbstractPhp56Extension
  init
  desc "Replication and load balancing plugin for mysqlnd"
  homepage "https://pecl.php.net/package/mysqlnd_ms"
  url "https://pecl.php.net/get/mysqlnd_ms-1.5.2.tgz"
  sha256 "22b9ba1afb36b3df11c1051c813bc07889c815d1d9993bb07ffda182665b472f"
  head "https://svn.php.net/repository/pecl/mysqlnd_ms/trunk/"

  stable do
    patch :DATA
  end

  bottle do
    sha256 "0e82ec4233e437bcae9417e5a0e90f7885c2c41fd1684e1994951725bec2a09a" => :yosemite
    sha256 "82e862d09fb3479ffe46a9f3437f228bece64d59c806e89cba929fd346fe1bbd" => :mavericks
    sha256 "e611764537c51fff064e2001ed4a37fc791442576af7e8b81400d05ffe0736c8" => :mountain_lion
  end

  def extension
    "mysqlnd_ms"
  end

  def install
    Dir.chdir extension + "-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mysqlnd-ms"

    system "make"
    prefix.install "modules/" + extension + ".so"
    write_config_file if build.with? "config-file"
  end
end

__END__
diff --git a/mysqlnd_ms-1.5.2/mysqlnd_ms.c b/mysqlnd_ms-1.5.2/mysqlnd_ms.c
index e8cf8fa..5a1c063 100644
--- a/mysqlnd_ms-1.5.2/mysqlnd_ms.c
+++ b/mysqlnd_ms-1.5.2/mysqlnd_ms.c
@@ -549,7 +549,7 @@ mysqlnd_ms_connect_to_host(MYSQLND_CONN_DATA * proxy_conn, MYSQLND_CONN_DATA * c
			if (conn && i==0) {
				tmp_conn = conn;
			} else {
-				tmp_conn_handle = mysqlnd_init(persistent);
+				tmp_conn_handle = mysqlnd_init(proxy_conn->m->get_client_api_capabilities(proxy_conn TSRMLS_CC), persistent);
				if (tmp_conn_handle) {
					tmp_conn = MS_GET_CONN_DATA_FROM_CONN(tmp_conn_handle);
				}
@@ -1085,7 +1085,7 @@ MYSQLND_METHOD(mysqlnd_ms, use_result)(MYSQLND_CONN_DATA * const proxy_conn TSRM
	MYSQLND_CONN_DATA * conn = ((*conn_data) && (*conn_data)->stgy.last_used_conn)? (*conn_data)->stgy.last_used_conn:proxy_conn;
	DBG_ENTER("mysqlnd_ms::use_result");
	DBG_INF_FMT("Using thread "MYSQLND_LLU_SPEC, conn->thread_id);
-	result = MS_CALL_ORIGINAL_CONN_DATA_METHOD(use_result)(conn TSRMLS_CC);
+	result = MS_CALL_ORIGINAL_CONN_DATA_METHOD(use_result)(conn, MYSQLND_STORE_NO_COPY TSRMLS_CC);
	DBG_RETURN(result);
 }
 /* }}} */
@@ -1100,7 +1100,7 @@ MYSQLND_METHOD(mysqlnd_ms, store_result)(MYSQLND_CONN_DATA * const proxy_conn TS
	MYSQLND_CONN_DATA * conn = ((*conn_data) && (*conn_data)->stgy.last_used_conn)? (*conn_data)->stgy.last_used_conn:proxy_conn;
	DBG_ENTER("mysqlnd_ms::store_result");
	DBG_INF_FMT("Using thread "MYSQLND_LLU_SPEC, conn->thread_id);
-	result = MS_CALL_ORIGINAL_CONN_DATA_METHOD(store_result)(conn TSRMLS_CC);
+	result = MS_CALL_ORIGINAL_CONN_DATA_METHOD(store_result)(conn, MYSQLND_STORE_NO_COPY TSRMLS_CC);
	DBG_RETURN(result);
 }
 /* }}} */
diff --git a/mysqlnd_ms-1.5.2/mysqlnd_ms_filter_qos.c b/mysqlnd_ms-1.5.2/mysqlnd_ms_filter_qos.c
index 913f1cb..0a03e1d 100644
--- a/mysqlnd_ms-1.5.2/mysqlnd_ms_filter_qos.c
+++ b/mysqlnd_ms-1.5.2/mysqlnd_ms_filter_qos.c
@@ -202,7 +202,7 @@ mysqlnd_ms_qos_server_has_gtid(MYSQLND_CONN_DATA * conn, MYSQLND_MS_CONN_DATA **
	do {
		if ((PASS == MS_CALL_ORIGINAL_CONN_DATA_METHOD(send_query)(conn, sql, sql_len TSRMLS_CC)) &&
			(PASS ==  MS_CALL_ORIGINAL_CONN_DATA_METHOD(reap_query)(conn TSRMLS_CC)) &&
-			(res = MS_CALL_ORIGINAL_CONN_DATA_METHOD(store_result)(conn TSRMLS_CC)))
+			(res = MS_CALL_ORIGINAL_CONN_DATA_METHOD(store_result)(conn, MYSQLND_STORE_NO_COPY TSRMLS_CC)))
		{
			ret = (MYSQLND_MS_UPSERT_STATUS(conn).affected_rows) ? PASS : FAIL;
			DBG_INF_FMT("sql = %s -  ret = %d - affected_rows = %d", sql, ret, (MYSQLND_MS_UPSERT_STATUS(conn).affected_rows));
@@ -307,7 +307,7 @@ mysqlnd_ms_qos_server_get_lag_stage2(MYSQLND_CONN_DATA * conn, MYSQLND_MS_CONN_D
	(*conn_data)->skip_ms_calls = TRUE;

	if ((PASS == MS_CALL_ORIGINAL_CONN_DATA_METHOD(reap_query)(conn TSRMLS_CC)) &&
-		(res = MS_CALL_ORIGINAL_CONN_DATA_METHOD(store_result)(conn TSRMLS_CC)))
+		(res = MS_CALL_ORIGINAL_CONN_DATA_METHOD(store_result)(conn, MYSQLND_STORE_NO_COPY TSRMLS_CC)))
	{
		zval * row;
		zval ** seconds_behind_master;
diff --git a/mysqlnd_ms-1.5.2/php_mysqlnd_ms.c b/mysqlnd_ms-1.5.2/php_mysqlnd_ms.c
index e067a72..74b3dda 100644
--- a/mysqlnd_ms-1.5.2/php_mysqlnd_ms.c
+++ b/mysqlnd_ms-1.5.2/php_mysqlnd_ms.c
@@ -290,7 +290,7 @@ static PHP_FUNCTION(mysqlnd_ms_get_last_used_connection)
	if (zend_parse_parameters(ZEND_NUM_ARGS() TSRMLS_CC, "z", &handle) == FAILURE) {
		return;
	}
-	if (!(proxy_conn = zval_to_mysqlnd(handle TSRMLS_CC))) {
+	if (!(proxy_conn = zval_to_mysqlnd_inherited(handle TSRMLS_CC))) {
		RETURN_FALSE;
	}
	{
@@ -330,7 +330,7 @@ static PHP_FUNCTION(mysqlnd_ms_get_last_gtid)
	if (zend_parse_parameters(ZEND_NUM_ARGS() TSRMLS_CC, "z", &handle) == FAILURE) {
		return;
	}
-	if (!(proxy_conn = zval_to_mysqlnd(handle TSRMLS_CC))) {
+	if (!(proxy_conn = zval_to_mysqlnd_inherited(handle TSRMLS_CC))) {
		RETURN_FALSE;
	}
	{
@@ -370,7 +370,7 @@ static PHP_FUNCTION(mysqlnd_ms_get_last_gtid)
			goto getlastidfailure;
		}

-		if (!(res = MS_CALL_ORIGINAL_CONN_DATA_METHOD(store_result)(conn TSRMLS_CC))) {
+		if (!(res = MS_CALL_ORIGINAL_CONN_DATA_METHOD(store_result)(conn, MYSQLND_STORE_NO_COPY TSRMLS_CC))) {
			goto getlastidfailure;
		}

@@ -503,7 +503,7 @@ static PHP_FUNCTION(mysqlnd_ms_set_qos)
		option = QOS_OPTION_NONE;
	}

-	if (!(proxy_conn = zval_to_mysqlnd(handle TSRMLS_CC))) {
+	if (!(proxy_conn = zval_to_mysqlnd_inherited(handle TSRMLS_CC))) {
		RETURN_FALSE;
	}
