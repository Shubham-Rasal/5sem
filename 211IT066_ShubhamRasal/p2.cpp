#include <iostream>
#include <bits/stdc++.h>

using namespace std;
void print(vector<int> a)
{
    if (a[a.size() - 1] != 0)
        cout << a[a.size() - 1];
    for (int i = a.size() - 2; i >= 0; i--)
    {
        cout << a[i];
    }
    cout << endl;
}

vector<int> sum(vector<int> &x, vector<int> &y)
{
    vector<int> sum;
    int n = x.size(), m = y.size();
    int carry = 0;
    for (int i = 0; i < min(m, n); i++)
    {
        int temp = x[i] + y[i] + carry;
        sum.push_back(temp % 10);
        carry = temp / 10;
    }
    if (m > n)
    {
        y[n] += carry;
        sum.push_back(y[n] % 10);
        carry = y[n] / 10;
        for (int i = n + 1; i < m; i++)
        {
            sum.push_back((y[i] + carry) % 10);
            carry = (y[i] + carry) / 10;
        }
    }
    else if (n > m)
    {
        x[m] += carry;
        sum.push_back(x[m] % 10);
        carry = x[m] / 10;
        for (int i = m + 1; i < n; i++)
        {
            sum.push_back((x[i] + carry) % 10);
            carry = (x[i] + carry) / 10;
        }
    }
    else
    {
        sum.push_back(carry);
    }
    return sum;
}

vector<int> subtract(vector<int> &x, vector<int> &y)
{
    vector<int> diff;
    int n = x.size(), m = y.size();
    int carry = 0;
    for (int i = 0; i < min(m, n); i++)
    {
        int temp = x[i] - y[i] - carry;
        if (temp < 0)
        {
            temp += 10;
            carry = 1;
        }
        else
        {
            carry = 0;
        }
        diff.push_back(temp);
    }
    if (m > n)
    {
        y[n] -= carry;
        diff.push_back(y[n]);
        for (int i = n + 1; i < m; i++)
        {
            diff.push_back(y[i]);
        }
    }
    else if (n > m)
    {
        x[m] -= carry;
        diff.push_back(x[m]);
        for (int i = m + 1; i < n; i++)
        {
            diff.push_back(x[i]);
        }
    }
    else
    {
        diff.push_back(carry);
    }
    return diff;
}


vector<int> karatsuba(vector<int> &x, vector<int> &y)
{
    // recursive base case
    // cout<<"efef";
    int n = x.size(), m = y.size();
    vector<int> result;
    if (n == 1)
    {
        result.push_back((x[0] * y[0]) % 10);
        result.push_back((x[0] * y[0] / 10));
        return result;
    }

    // recursive step
    vector<int> a;
    vector<int> b;
    vector<int> c;
    vector<int> d;

    for (int i = 0; i < n / 2; i++)
    {
        b.push_back(x[i]);
        d.push_back(y[i]);
    }

    for (int i = n / 2; i < n; i++)
    {
        a.push_back(x[i]);
        c.push_back(y[i]);
    }

    vector<int> ac = karatsuba(a, c);
    vector<int> bd = karatsuba(b, d);
    vector<int> sum_ab = sum(a, b);
    vector<int> sum_cd = sum(c, d);
    vector<int> abcd = karatsuba(sum_ab, sum_cd);
    vector<int> to_subtract = sum(ac, bd);
    abcd = subtract(abcd, to_subtract);

    int len = ac.size();
    vector<int> n_zeros(n, 0);
    for (int i = 0; i < ac.size(); i++)
    {
        n_zeros.push_back(ac[i]);
    }
    vector<int> n2_zeros(n / 2, 0);
    for (int i = 0; i < abcd.size(); i++)
    {
        n2_zeros.push_back(abcd[i]);
    }
    result = sum(n_zeros, n2_zeros);
    result = sum(result, bd);
    return result;

    return result;
}

int main()
{
    int temp;
     // 3141592653589793238462643383279502884197169399375105820974944592
    vector<int> x = {3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5,
                     8, 9, 7, 9, 3, 2, 3, 8, 4, 6,
                     2, 6, 4, 3, 3, 8, 3, 2, 7, 9,
                     5, 0, 2, 8, 8, 4, 1, 9, 7, 1,
                     6, 9, 3, 9, 9, 3, 7, 5, 1, 0,
                     5, 8, 2, 0, 9, 7, 4, 9, 4, 4,
                     5, 9, 2};
    // 2718281828459045235360287471352662497757247093699959574966967627

    vector<int> y = {2, 7, 1, 8, 2, 8, 1, 8, 2, 8, 4, 5, 9, 0, 4, 5, 2, 3, 5, 3,
                     6, 0, 2, 8, 7, 4, 7, 1, 3, 5, 2, 6, 6, 2, 4, 9, 7, 7, 5, 7,
                     2, 4, 7, 0, 9, 3, 6, 9, 9, 9, 5, 9, 5, 7, 4, 9, 6, 6, 9, 6,
                     7, 6, 2, 7};
    for (int i = 0, j = x.size() - 1; i <= j; i++, j--)
    {
        temp = x[i];
        x[i] = x[j];
        x[j] = temp;
    }
    for (int i = 0, j = y.size() - 1; i <= j; i++, j--)
    {
        temp = y[i];
        y[i] = y[j];
        y[j] = temp;
    }
    if (x.size() >= y.size())
    {
        if (x.size() % 2 == 1)
        {
            x.push_back(0);
        }
        for (int i = 0; i < x.size() - y.size(); i++)
        {
            y.push_back(0);
        }
    }
    else
    {
        if (y.size() % 2 == 1)
        {
            y.push_back(0);
        }
        for (int i = 0; i < y.size() - x.size(); i++)
        {
            y.push_back(0);
        }
    }
    // cout<<"efef";
    vector<int> result = karatsuba(x, y);

    print(result);

    return 0;
}
