if not command -s direnv > /dev/null
    echo "Install direnv."
    exit 1
end

eval (direnv hook fish)
