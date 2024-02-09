UPDATE twofer
SET response = 'One for ' ||
                CASE
                    WHEN input = '' THEN 'you'
                    ELSE input
                END || ', one for me.';
    