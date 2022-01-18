function out = compute_choiceProb_v1( mean_error, var_error, actual_error, type)

switch type
    case 'normal'
        out = 1 ./ sqrt(2*pi*var_error) .* exp(- ( actual_error - mean_error).^2 ./ (2 * var_error));
    case 'log'
        out = -log(sqrt(2*pi*var_error)) - ( actual_error - mean_error).^2 ./ (2 * var_error);
end
