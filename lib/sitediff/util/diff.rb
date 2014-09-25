require 'diffy'
require 'erb'

class SiteDiff
  module Util
    module Diff
      module_function

      def html_diffy(before_html, after_html)
        diff = Diffy::Diff.new(before_html, after_html)
        diff.first ?  # Is it non-empty?
          diff.to_s(:html) : nil
      end

      def terminal_diffy(before_html, after_html)
        return Diffy::Diff.new(before_html, after_html, :context => 3).to_s(:color)
      end

      def generate_html_report(results, before, after)
        erb_path = File.join([File.dirname(__FILE__), 'html_report.html.erb'])
        report_html = ERB.new(File.read(erb_path)).result(binding)
        return report_html
      end

      def generate_diff_output(result)
        erb_path = File.join([File.dirname(__FILE__), 'diff.html.erb'])
        return ERB.new(File.read(erb_path)).result(binding)
      end
    end
  end
end
