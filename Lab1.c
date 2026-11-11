//
// Created by bogus on 15/09/2026.
//

#include <stdio.h>
#include <math.h>

// Task 1 //

int main(void) {
    double x, y;

    if (scanf("%lf %lf", &x, &y) == 2) {

        double r = sqrt(x * x + y * y);
        double theta = atan2(y, x);

        if (theta >= 3.1415 - 1e-9) {
            theta -= 2.0 * 3.1415;
        }

        printf("%.2f %.2f\n", r, theta);
    }

    return 0;
}


// Task 2 //

int main(void) {
    double r, theta;

    if (scanf("%lf %lf", &r, &theta) == 2) {

        double x = r * cos(theta);
        double y = r * sin(theta);


        printf("%.2f %.2f\n", x, y);
    }

    return 0;
}


// Task 3 //

int main(void) {
    double f, A0, pheta0, A1, pheta1;

    if (scanf("%lf %lf %lf %lf %lf", &f, &A0, &pheta0, &A1, &pheta1 ) == 5) {

        double A_sum = sqrt( pow(A0 * cos(pheta0) + A1 * cos(pheta1), 2) + pow(A0 * sin(pheta0) + A1 * sin(pheta1), 2) ) ;
        double pheta_sum = atan2((A0 * sin(pheta0) + A1 * sin(pheta1)), (A0 * cos(pheta0) + A1 * cos(pheta1)));

        if (pheta_sum >= 3.1415 - 1e-9) {
            pheta_sum -= 2.0 * 3.1415;
        }

        if (A_sum <= 0.0005) {
            printf("x(t)=0.00\n");
        } else {
            printf("x(t)=%.2f*cos(2*pi*%.2f*t+%.2f)\n", A_sum, f, pheta_sum);
        }

    }

    return 0;
}


// Task 4 //

int main(void) {
    int f_s;
    int n;
    double A, f, pheta;

    if (scanf("%d %d %lf %lf %lf", &f_s, &n, &A, &f, &pheta ) == 5) {
        int solution[n];

        for (int i = 0; i < n; i++) {
            double t = (double)i / f_s;
            solution[i] = (int)(A * cos(2.0 * 3.141592653589793 * f * t + pheta));
        }

        printf("[");
        for (int i = 0; i < n; i++) {
            printf("%d", solution[i]);
            if (i < n - 1) {
                printf(",");
            }
        }
        printf("]\n");
    }

    return 0;
}


// Task 5 //

int main(void) {
    int f_s, n;
    int m;

    if (scanf("%d %d", &f_s, &n ) == 2) {
        if (scanf("%d", &m) == 1) {
            double A[m];
            double f[m];
            double pheta[m];

            int solution[n];

            for (int j = 0; j < m; j++) {
                scanf("%lf %lf %lf", &A[j], &f[j], &pheta[j]);
            }

            for (int i = 0; i < n; i++) {
                double sum = 0.0;
                double t = (double)i / f_s;
                for (int j = 0; j < m; j++) {
                    sum += (A[j] * cos(2.0 * 3.141592653589793 * f[j] * t + pheta[j]));
                }
                solution[i] = (int)sum;
            }

            printf("[");
            for (int i = 0; i < n; i++) {
                printf("%d", solution[i]);
                if (i < n - 1) {
                    printf(",");
                }
            }
            printf("]\n");
        }
    }
    return 0;
}

// Task 6 //

int main(void) {
    int f_s;

    if (scanf("%d", &f_s ) == 1) {
        double A[2];
        double f[2];
        double pheta[2];

        if (scanf("%lf %lf %lf %lf %lf %lf", &A[0], &f[0], &pheta[0], &A[1], &f[1], &pheta[1]) == 6) {
            double t = (double)1 / f_s;

            double val1 = A[0] * cos(2.0 * 3.141592653589793 * f[0] * t + pheta[0]);
            double val2 = A[1] * cos(2.0 * 3.141592653589793 * f[1] * t + pheta[1]);

            if (fabs(val1 - val2) < 1e-9) {
                printf("YES\n");
            } else {
                printf("NO\n");
            }
        }
    }

    return 0;
}

// Task 7 //

int main(void) {
    double A, f, pheta;
    double x0, x1, x2;


    while (scanf("%lf %lf %lf %lf %lf %lf", &A, &f, &pheta, &x0, &x1, &x2) == 6) {
        double d0 = fabs(x2 - x0);
        double d1 = fabs(x2 - x1);

        double phase_diff = (3.141492 * f / 343) * (d1 - d0);
        double result = 2.0 * A * fabs(cos(phase_diff));

        printf("%.2f\n", result);
    }

    while (scanf("%lf %lf %lf %lf %lf %lf", &A, &f, &pheta, &x0, &x1, &x2) != 6) {
        break;
    }

    return 0;
}

// Task 8 //

int gcd(int a, int b)
{
    if (a == 0)
        return b;
    if (b == 0)
        return a;

    if (a == b)
        return a;

    //using euclidean algorithm here

    if (a > b)
        return gcd(a - b, b);
    return gcd(a, b - a);
}

long long lcm(long long a, long long b) {
    return (a / gcd(a, b)) * b;
}

int main(void) {
    int n;

    if (scanf("%d", &n) != 1) return 1;
    double A[n];
    int T[n];
    double pheta[n];

    int final_solution[n];

    for (int j = 0; j < n; j++) {
        scanf("%lf %d %lf", &A[j], &T[j], &pheta[j]);
    }

    long long overall_lcm = T[0];
    for (int i = 1; i < n; i++) {
        overall_lcm = lcm(overall_lcm, T[i]);
    }


    printf("%lld\n", overall_lcm);

    return 0;
}

// Task 9 //


int main(void) {
    double f0;
    double f1;


    while (scanf("%lf %lf", &f0, &f1) == 2) {

        double f2 = fabs(f1 - f0) / 2;

        double f3 = (f0 + f1) / 2;

        printf("%.2f\n%.2f\n", f2, f3);
    }

    return 0;
}
