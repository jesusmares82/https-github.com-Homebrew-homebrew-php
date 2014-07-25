require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Uploadprogress < AbstractPhp55Extension
  init
  homepage 'http://pecl.php.net/package/uploadprogress'
  url 'http://pecl.php.net/get/uploadprogress-1.0.3.1.tgz'
  sha1 '5fd50a1d5d3ee485e31e16d76b686873125e8dec'
  head 'https://svn.php.net/repository/pecl/uploadprogress/trunk/'

  depends_on 'pcre'

  def install
    Dir.chdir "uploadprogress-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                            phpconfig
    system "make"
    prefix.install "modules/uploadprogress.so"
    write_config_file if build.with? "config-file"
  end
end
