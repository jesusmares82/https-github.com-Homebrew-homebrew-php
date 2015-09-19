require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Pdflib < AbstractPhp56Extension
  init
  homepage 'http://www.pdflib.com'
  url 'https://pecl.php.net/get/pdflib-3.0.4.tgz'
  sha256 '18de7bf00983a5b0fbbd4f7e993ecf948217072ae6ebff9fbb0eef88b8984b7e'

  depends_on "pdflib-lite"

  def install
    Dir.chdir "pdflib-#{version}"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/pdf.so"
    write_config_file if build.with? "config-file"
  end
end
