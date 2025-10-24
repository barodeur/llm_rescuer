module LlmRescuer
  module Tools
    class ReadSourceCodeTool < RubyLLM::Tool
      description "Reads the source code of a given file"

      param :file_path, desc: "The full path to the file to read, without the line number"
      param :around_line_number, desc: "The line number around which to read the source code"
      param :context_lines, desc: "The number of lines of context to include around the specified line number"

      def execute(file_path:, around_line_number:, context_lines:)
        around_line_number = around_line_number.to_i
        context_lines = context_lines.to_i
        return {error: "Unauthorized file path"} unless file_path.start_with?(LlmRescuer.prefix)

        return {error: "File not found"} unless File.file?(file_path)

        lines = File.readlines(file_path)

        start = [around_line_number - context_lines - 1, 0].max
        end_ = [around_line_number + context_lines - 1, lines.size - 1].min

        snippet = lines[start..end_].each_with_index.map do |src, i|
          num = start + i + 1
          prefix = (num == around_line_number) ? "=> " : "   "
          format("#{prefix}%4d | %s", num, src)
        end

        puts "#{file_path}:#{around_line_number}\n\n"
        puts snippet.join
      rescue => e
        {error: e.message}
      end
    end
  end
end
