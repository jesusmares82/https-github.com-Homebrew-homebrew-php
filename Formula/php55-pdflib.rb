require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php55Pdflib < AbstractPhp55Extension
  init
  homepage 'http://www.pdflib.com'
  url 'http://pecl.php.net/get/pdflib-3.0.1.tgz'
  sha1 '464b5fb640c30d218ae0ea64f9061591ec2a61eb'

  depends_on "pdflib-lite"

  def install
    Dir.chdir "pdflib-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/pdf.so"
    write_config_file unless build.include? "without-config-file"
  end
end
