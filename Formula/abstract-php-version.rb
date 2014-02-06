class AbstractPhpVersion < Formula
  def initialize name='__UNKNOWN__', path=nil
    begin
      raise "One does not simply install an AbstractPhp formula" if name == "abstract-php-version"
      super
    rescue Exception => e
      # Hack so that we pass all brew doctor tests
      reraise = e.backtrace.select { |l| l.match(/(doctor|cleanup|leaves|uses)\.rb/) }
      raise e if reraise.empty?
    end
  end

  module Php56Defs
    PHP_SRC_TARBALL = 'http://downloads.php.net/tyrael/php-5.6.0alpha1.tar.bz2'
    PHP_GITHUB_URL  = 'https://github.com/php/php-src.git'
    PHP_VERSION     = '5.6.0-alpha.1'
    PHP_BRANCH      = 'PHP-5.6'

    PHP_CHECKSUM    = {
                        :md5    => 'd1ac1df6ff701546a005e2d9799d2002',
                        :sha1   => '08dec1cd5ef3acccaafd7ca79f5a8b22643e7d65',
                        :sha256 => '17123fd1b07aa1cd16eedc9ae653dfbd560e2b7da95961f546334fda14bba804',
                      }
  end
end