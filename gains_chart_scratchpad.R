library(ggplot2)

# https://github.com/topepo/caret/issues/656
# https://heuristically.wordpress.com/2009/12/18/plot-roc-curve-lift-chart-random-forest/


# manual gains chart

df <- data.frame(prob = c(.78, .78, .36, .31, .18, .09, .085, 0), prob_overall = c(.10, .10, .10, .10, .10, .10, .10, .10), 
                 cum_pct_obs = c(0, .04, .09, .15, .22, .27, .32, 1), cum_true_positive_rate = c(0, .4, .42, .6, .8, .9, 1, 1),
                 terminal_node = c(5, 7, 3, 6, 1, 8, 4, 2))
df


line1 <- data.frame(x1 = 0, x2 = 1, y1 = 0, y2 = 1)
line2 <- data.frame(x1 = 0, x2 = df$prob_overall[1], y1 = 0, y2 = 1)
line3 <- data.frame(x1 = df$prob_overall[1], x2 = 1, y1 = 1, y2 = 1)

gains_chart <- ggplot(df, aes(x = cum_pct_obs, y = cum_true_positive_rate)) + 
        geom_line() + geom_point() + geom_text(aes(label = terminal_node), position = position_nudge(x = .03, y = -.03)) +
        ggtitle(str_c("Cumulative gains for training dataset")) + 
        geom_segment(data = line1, aes(x = x1, y = y1, xend = x2, yend = y2), alpha = 1, lty = "dashed") + 
        geom_segment(data = line2, aes(x = x1, y = y1, xend = x2, yend = y2), alpha = 1, lty = "dotted") +
        geom_segment(data = line3, aes(x = x1, y = y1, xend = x2, yend = y2), alpha = 1, lty = "dotted")
gains_chart