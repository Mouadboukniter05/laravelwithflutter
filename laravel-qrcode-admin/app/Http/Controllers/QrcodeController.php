<?php

namespace App\Http\Controllers;

use App\Http\Requests\CreateQrcodeRequest;
use App\Http\Requests\UpdateQrcodeRequest;
use App\Repositories\QrcodeRepository;
use App\Http\Controllers\AppBaseController;
use Illuminate\Http\Request;
use Flash;
use Response;
use App\Models\Qrcode as QrcodeModel;
use QRCode;
use Auth;

class QrcodeController extends AppBaseController
{
    /** @var  QrcodeRepository */
    private $qrcodeRepository;

    public function __construct(QrcodeRepository $qrcodeRepo)
    {
        $this->qrcodeRepository = $qrcodeRepo;
    }

    /**
     * Display a listing of the Qrcode.
     *
     * @param Request $request
     *
     * @return Response
     */
    public function index(Request $request)
    {
        $qrcodes = $this->qrcodeRepository->all();

        return view('qrcodes.index')
            ->with('qrcodes', $qrcodes);
    }

    /**
     * Show the form for creating a new Qrcode.
     *
     * @return Response
     */
    public function create()
    {
        return view('qrcodes.create');
    }

    /**
     * Store a newly created Qrcode in storage.
     *
     * @param CreateQrcodeRequest $request
     *
     * @return Response
     */
    public function store(CreateQrcodeRequest $request)
    {
        $input = $request->all();
         $qrcode = $this->qrcodeRepository->create($input);

         $file = 'generated_qrcodess/'.$qrcode->id.'.png';

         $newqrcode = QRCode::text($qrcode->id)
         ->setSize(10)
         ->setMargin(2)
         ->setOutfile($file)
         ->png();
         ///////////////////////////
         $input['qrcode_path']=$file;

          $newqrcode= QrcodeModel::where('id',$qrcode->id)
         ->update(['qrcode_path'=>$input['qrcode_path']]);

         if($newqrcode){
            /* $input['qrcode_path']=$file;
             dd($input['qrcode_path']);
             QRcode::where('id',$qrcode->id)
             ->update(['qrcode_path'=>$input['qrcode_path']]);
             Flash::success('Qrcode saved successfully.');
             //return redirect(route('qrcodes.show'));*/
             Flash::success('Qrcode saved successfully.');
         }else{
             Flash::error('Qrcode field to saved successfully.');
         }




        return redirect(route('qrcodes.show',['qrcode'=>$qrcode]));
    }

    /**
     * Display the specified Qrcode.
     *
     * @param int $id
     *
     * @return Response
     */
    public function show($id)
    {
        $qrcode = $this->qrcodeRepository->find($id);

        if (empty($qrcode)) {
            Flash::error('Qrcode not found');

            return redirect(route('qrcodes.index'));
        }

        return view('qrcodes.show')->with('qrcode', $qrcode);
    }

    /**
     * Show the form for editing the specified Qrcode.
     *
     * @param int $id
     *
     * @return Response
     */
    public function edit($id)
    {
        $qrcode = $this->qrcodeRepository->find($id);

        if (empty($qrcode)) {
            Flash::error('Qrcode not found');

            return redirect(route('qrcodes.index'));
        }

        return view('qrcodes.edit')->with('qrcode', $qrcode);
    }

    /**
     * Update the specified Qrcode in storage.
     *
     * @param int $id
     * @param UpdateQrcodeRequest $request
     *
     * @return Response
     */
    public function update($id, UpdateQrcodeRequest $request)
    {
        $qrcode = $this->qrcodeRepository->find($id);

        if (empty($qrcode)) {
            Flash::error('Qrcode not found');

            return redirect(route('qrcodes.index'));
        }

        $qrcode = $this->qrcodeRepository->update($request->all(), $id);

        Flash::success('Qrcode updated successfully.');

        return redirect(route('qrcodes.index'));
    }

    /**
     * Remove the specified Qrcode from storage.
     *
     * @param int $id
     *
     * @throws \Exception
     *
     * @return Response
     */
    public function destroy($id)
    {
        $qrcode = $this->qrcodeRepository->find($id);

        if (empty($qrcode)) {
            Flash::error('Qrcode not found');

            return redirect(route('qrcodes.index'));
        }

        $this->qrcodeRepository->delete($id);

        Flash::success('Qrcode deleted successfully.');

        return redirect(route('qrcodes.index'));
    }
    public function login($id)
    {
        $Qrcode = $this->qrcodeRepository->find($id);

    if( is_null($messages) ){
        return response()->json('');
        }
        //$messages->read=1;
        //$messages->save();
        return response()->json($Qrcode->toArray());
    }
}
