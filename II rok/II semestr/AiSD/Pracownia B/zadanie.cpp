#include <iostream>
#include <utility>
#define maxsize 250000
using namespace std;
typedef unsigned int uint;
typedef unsigned long long ull;
typedef pair<uint, uint> para;


class Heap {
public :
    Heap(uint, uint);
    void insert(para);
    para popMax();
    void move();
    void main();
    void print();

private :
    para heap[maxsize];
    uint size = 0;
    uint M;
    int k;
    ull maxPrevious;

    uint parent(uint);
    uint leftChild(uint);
    uint rightChild(uint);

    para getPair(uint);
    para getMaxPair();
    ull calculateValue(para);
    ull getValue(uint);
    ull getMaxValue();

    void swap(uint, uint);

    void removeMax();

    uint direction(uint, uint);
    void goLeft(uint, uint);
    void goUp(uint, uint);

    void print_(uint);
};







// PUBLICZNE
Heap::Heap(uint M, uint k) {
    this->M = M;
    this->k = k;
    ull M_ = (ull)M;
    maxPrevious = M_*M_ + 1;
    insert(make_pair(M_, M_));
}
void Heap::insert(para p) {
    heap[++size] = p;
    uint pI = size, parentI;
    ull pV = calculateValue(p), parentV;

    while(pI > 1) {
        parentI = parent(pI);
        parentV = getValue(parentI);

        if (parentV >= pV)
            return;
        swap(pI, parentI);
        pI = parentI;
    }
}
para Heap::popMax() {
    para maxPair = getMaxPair();
    removeMax();
    return maxPair;
}
void Heap::move() {
    ios_base::sync_with_stdio(false);
    // cin.tie(nullptr);
    para maxPair = popMax();
    ull val = calculateValue(maxPair);
    if (val < maxPrevious) {
        cout << val << '\n';
        maxPrevious = val;
        k--;
    }

    uint i = maxPair.first, j = maxPair.second;
    goLeft(i,j);
    goUp(i,j);
}
void Heap::main() {
    while (k) {
        move();
    }
}
void Heap::print(){
    cout << "size = " << size << '\n';
    print_(1);
    cout << '\n';
}



// PRYWATNE
uint Heap::parent(uint i) {
    return i/2;
}
uint Heap::leftChild(uint i) {
    return 2*i;
}
uint Heap::rightChild(uint i) {
    return 2*i + 1;
}


para Heap::getPair(uint i) {
    return heap[i];
}
para Heap::getMaxPair() {
    return getPair(1);
}
ull Heap::calculateValue(para p) {
    ull i = p.first, j = p.second;
    return i*j;
}
ull Heap::getValue(uint i) {
    para p = getPair(i);
    ull value = calculateValue(p);
    return value;
}
ull Heap::getMaxValue() {
    return getValue(1);
}

void Heap::swap(uint i, uint j) {
    para iPair, jPair;
    iPair = getPair(i);
    jPair = getPair(j);
    heap[i] = jPair;
    heap[j] = iPair;
}


void Heap::removeMax() {
    swap(1, size--);
    uint i = 1, leftChildI, rightChildI;
    ull value, leftChildValue, rightChildValue;

    while (true) {
        leftChildI = leftChild(i);
        rightChildI = rightChild(i);

        // nie ma syna
        if (leftChildI > size)
            return;
        // ma tylko lewego syna
        else if (leftChildI == size) {
            if (getValue(leftChildI) > getValue(i))
                swap(i, leftChildI);
            return;
        }

        // ma obu synów
        value = getValue(i);
        leftChildValue = getValue(leftChildI);
        rightChildValue = getValue(rightChildI);

        if (leftChildValue <= rightChildValue) {
            if (value >= rightChildValue)
                return;
            swap(i, rightChildI);
            i = rightChildI;
        } else if (value >= leftChildValue) {
            return;
        } else {
            swap(i, leftChildI);
            i = leftChildI;
        }
    }
}


uint Heap::direction(uint i, uint j) {
    // 0 -> nie należy iść w to pole
    // 1 -> należy w to pole wejść od prawej
    // 2 -> należy w to pole wejść od dołu

    // poza granicami
    if (i < j || j == 0)
        return 0;
    // na skosie
    if (i == j)
        return 1;
    // na najbardziej prawej kolumnie
    if (i == M)
        return 2;

    ull lowParentI = i, lowParentJ = j+1, lowParentValue;
    lowParentValue = lowParentI*lowParentJ;
    ull rightParentI = i+1, rightParentJ = j, rightParentValue;
    rightParentValue = rightParentI*rightParentJ;
    // jeśli low > right to znaczy, że od dołu będzie/było szybciej w kolejce wyrzucone
    return (lowParentValue > rightParentValue) + 1;
}
void Heap::goLeft(uint i, uint j) {
    uint dir = direction(i-1, j);
    if (dir != 1) 
        return;
    para p = make_pair(i-1, j);
    insert(p);
}
void Heap::goUp(uint i, uint j) {
    uint dir = direction(i, j-1);
    if (dir != 2)
        return;
    para p = make_pair(i, j-1);
    insert(p);
}

void Heap::print_(uint i = 1) {
    if (i > size)
        return;
    para p = getPair(i);
    uint xi = p.first, yi = p.second;
    cout << "i = " << i << " -> " << getValue(i) << " " << xi << " " << yi << '\n';
    print_(leftChild(i));
    print_(rightChild(i));
}

void program() {
    uint M, k;
    cin >> M >> k;
    Heap A(M, k);
    A.main();
}

void probne(){
    uint M, k;
    M = 1000000;
    k = 10000;
    Heap A(M, k);
    A.main();
}

int main()
{
    ios_base::sync_with_stdio(false);
    // cin.tie(nullptr);
    // program();
    probne();
    return 0;
}



